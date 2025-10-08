import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';
import '../models/artwork.dart';
import '../services/artwork_service.dart';
import '../services/localization_service.dart';

/// AR Guide Mode - Artwork Recognition Screen
class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ARKitController arkitController;
  final FlutterTts flutterTts = FlutterTts();

  Artwork? detectedArtwork;
  bool isListening = false;
  bool isSpeaking = false;
  final Map<String, ARKitNode> _artworkNodes = {};

  @override
  void initState() {
    super.initState();
    _initializeTTS();
  }

  @override
  void dispose() {
    arkitController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  /// Initialize Text-to-Speech
  Future<void> _initializeTTS() async {
    final localizationService = Provider.of<LocalizationService>(
      context,
      listen: false,
    );
    final languageCode = localizationService.currentLocale.languageCode;

    // Set language based on current locale
    if (languageCode == 'fr') {
      await flutterTts.setLanguage('fr-FR');
    } else if (languageCode == 'wo') {
      // Wolof might not be available, fallback to French
      await flutterTts.setLanguage('fr-FR');
    } else {
      await flutterTts.setLanguage('en-US');
    }

    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    // Set up completion handler
    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });

    flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });
  }

  /// Called when ARKit view is created
  void _onARKitViewCreated(ARKitController controller) {
    arkitController = controller;

    // Set up anchor detection callback
    arkitController.onAddNodeForAnchor = _onAnchorDetected;
    arkitController.onUpdateNodeForAnchor = _onAnchorUpdated;
  }

  /// Called when an AR anchor is detected
  void _onAnchorDetected(ARKitAnchor anchor) {
    // Check if it's an image anchor
    if (anchor is ARKitImageAnchor) {
      final referenceImageName = anchor.referenceImageName;

      // Find the artwork by QR code (which matches reference image name)
      final artworkService = Provider.of<ArtworkService>(
        context,
        listen: false,
      );
      final artwork = artworkService.getArtworkByQRCode(referenceImageName);

      if (artwork != null) {
        setState(() {
          detectedArtwork = artwork;
        });

        // Add AR information card above the detected artwork
        _addArtworkInfoCard(anchor, artwork);

        // Auto-play narration
        _speakDescription(artwork);
      }
    }
  }

  /// Called when an anchor is updated
  void _onAnchorUpdated(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      // Update position if needed
    }
  }

  /// Add an AR information card above the detected artwork
  void _addArtworkInfoCard(ARKitImageAnchor anchor, Artwork artwork) {
    final localizationService = Provider.of<LocalizationService>(
      context,
      listen: false,
    );
    final languageCode = localizationService.currentLocale.languageCode;

    // Get localized text
    final title = artwork.getTitleForLocale(languageCode);

    // Create a plane to display info card
    final plane = ARKitPlane(
      width: 0.3,
      height: 0.15,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(
            AppColors.emerald.withOpacity(0.9),
          ),
        ),
      ],
    );

    // Position the card above the detected image
    final position = vector.Vector3(
      anchor.transform.getColumn(3).x,
      anchor.transform.getColumn(3).y + 0.15, // 15cm above the artwork
      anchor.transform.getColumn(3).z,
    );

    // Create node for the info card
    final node = ARKitNode(
      geometry: plane,
      position: position,
      eulerAngles: vector.Vector3(-1.57, 0, 0), // Rotate to face up
    );

    // Add text node (simplified - in production you'd use ARKitText or image overlay)
    final textPlane = ARKitPlane(
      width: 0.25,
      height: 0.05,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(Colors.white),
        ),
      ],
    );

    final textNode = ARKitNode(
      geometry: textPlane,
      position: vector.Vector3(0, 0.01, 0),
    );

    node.addChild(textNode);

    // Store and add to scene
    _artworkNodes[artwork.id] = node;
    arkitController.add(node);
  }

  /// Speak the artwork description using TTS
  Future<void> _speakDescription(Artwork artwork) async {
    final localizationService = Provider.of<LocalizationService>(
      context,
      listen: false,
    );
    final languageCode = localizationService.currentLocale.languageCode;

    final description = artwork.getDescriptionForLocale(languageCode);
    final title = artwork.getTitleForLocale(languageCode);

    // Speak title first, then description
    await flutterTts.speak('$title. $description');
  }

  /// Toggle narration on/off
  Future<void> _toggleNarration() async {
    if (isSpeaking) {
      await flutterTts.stop();
      setState(() {
        isSpeaking = false;
      });
    } else if (detectedArtwork != null) {
      await _speakDescription(detectedArtwork!);
    }
  }

  /// Clear detected artwork and remove AR nodes
  void _clearDetection() {
    for (final node in _artworkNodes.values) {
      arkitController.remove(node.name);
    }
    _artworkNodes.clear();

    flutterTts.stop();

    setState(() {
      detectedArtwork = null;
      isSpeaking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final localizationService = Provider.of<LocalizationService>(context);
    final languageCode = localizationService.currentLocale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.augmentedReality),
        backgroundColor: AppColors.emerald,
        foregroundColor: Colors.white,
        actions: [
          if (detectedArtwork != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _clearDetection,
              tooltip: localizations.close,
            ),
        ],
      ),
      body: Stack(
        children: [
          // AR View
          ARKitSceneView(
            onARKitViewCreated: _onARKitViewCreated,
            detectionImagesGroupName: 'AR Resources',
            enableTapRecognizer: true,
          ),

          // Instruction overlay (when no artwork detected)
          if (detectedArtwork == null)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.black.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        color: AppColors.emerald,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          localizations.arPointCamera,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Artwork detected information
          if (detectedArtwork != null)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Card(
                color: AppColors.emerald.withOpacity(0.95),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            localizations.arArtworkDetected,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        detectedArtwork!.getTitleForLocale(languageCode),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.access_time,
                        localizations.epoch,
                        detectedArtwork!.epoch,
                      ),
                      _buildInfoRow(
                        Icons.location_on,
                        localizations.origin,
                        detectedArtwork!.origin,
                      ),
                      _buildInfoRow(
                        Icons.category,
                        localizations.type,
                        detectedArtwork!.type,
                      ),
                      if (detectedArtwork!.artist != null)
                        _buildInfoRow(
                          Icons.person,
                          'Artiste',
                          detectedArtwork!.artist!,
                        ),
                    ],
                  ),
                ),
              ),
            ),

          // Narration controls
          if (detectedArtwork != null)
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSpeaking ? Icons.volume_up : Icons.volume_off,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        isSpeaking
                            ? localizations.arListening
                            : localizations.arTapToHear,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: Icon(
                          isSpeaking ? Icons.stop : Icons.play_arrow,
                          color: AppColors.emerald,
                        ),
                        onPressed: _toggleNarration,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Recognition status indicator
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: detectedArtwork != null
                            ? Colors.green
                            : Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      localizations.arRecognitionActive,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
