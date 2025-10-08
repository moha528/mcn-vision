import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';

/// Écran de réalité augmentée
class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ARKitController arkitController;
  final List<ARKitNode> _nodes = [];

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  void _onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    // Ajouter quelques objets initiaux pour démarrer
    _addSphere();
    _addCube();
    _addPyramid();
  }

  void _addSphere() {
    final random = Random();
    final position = vector.Vector3(
      (random.nextDouble() - 0.5) * 0.5,
      random.nextDouble() * 0.3,
      -(random.nextDouble() * 0.5 + 0.5),
    );

    final sphere = ARKitNode(
      geometry: ARKitSphere(
        radius: 0.05,
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.color(
              Color.fromRGBO(
                random.nextInt(255),
                random.nextInt(255),
                random.nextInt(255),
                1.0,
              ),
            ),
          ),
        ],
      ),
      position: position,
    );

    _nodes.add(sphere);
    arkitController.add(sphere);
    setState(() {});
  }

  void _addCube() {
    final random = Random();
    final position = vector.Vector3(
      (random.nextDouble() - 0.5) * 0.5,
      random.nextDouble() * 0.3,
      -(random.nextDouble() * 0.5 + 0.5),
    );

    final cube = ARKitNode(
      geometry: ARKitBox(
        width: 0.08,
        height: 0.08,
        length: 0.08,
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.color(
              Color.fromRGBO(
                random.nextInt(255),
                random.nextInt(255),
                random.nextInt(255),
                1.0,
              ),
            ),
          ),
        ],
      ),
      position: position,
      rotation: vector.Vector4(
        random.nextDouble(),
        random.nextDouble(),
        random.nextDouble(),
        random.nextDouble() * pi,
      ),
    );

    _nodes.add(cube);
    arkitController.add(cube);
    setState(() {});
  }

  void _addPyramid() {
    final random = Random();
    final position = vector.Vector3(
      (random.nextDouble() - 0.5) * 0.5,
      random.nextDouble() * 0.3,
      -(random.nextDouble() * 0.5 + 0.5),
    );

    final pyramid = ARKitNode(
      geometry: ARKitPyramid(
        width: 0.08,
        height: 0.12,
        length: 0.08,
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.color(
              Color.fromRGBO(
                random.nextInt(255),
                random.nextInt(255),
                random.nextInt(255),
                1.0,
              ),
            ),
          ),
        ],
      ),
      position: position,
    );

    _nodes.add(pyramid);
    arkitController.add(pyramid);
    setState(() {});
  }

  void _removeLastObject() {
    if (_nodes.isNotEmpty) {
      final node = _nodes.removeLast();
      arkitController.remove(node.name);
      setState(() {});
    }
  }

  void _clearAll() {
    for (final node in _nodes) {
      arkitController.remove(node.name);
    }
    _nodes.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.augmentedReality),
        backgroundColor: AppColors.emerald,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Vue AR
          ARKitSceneView(
            onARKitViewCreated: _onARKitViewCreated,
            enableTapRecognizer: true,
          ),

          // Overlay avec contrôles
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              color: Colors.black.withValues(alpha: 0.7),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Objets dans la scène: ${_nodes.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Boutons de contrôle en bas
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: Icons.circle,
                      label: 'Sphère',
                      color: Colors.blue,
                      onPressed: _addSphere,
                    ),
                    _buildControlButton(
                      icon: Icons.crop_square,
                      label: 'Cube',
                      color: Colors.green,
                      onPressed: _addCube,
                    ),
                    _buildControlButton(
                      icon: Icons.change_history,
                      label: 'Pyramide',
                      color: Colors.orange,
                      onPressed: _addPyramid,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: Icons.remove_circle,
                      label: 'Retirer',
                      color: Colors.red,
                      onPressed: _nodes.isNotEmpty ? _removeLastObject : null,
                    ),
                    _buildControlButton(
                      icon: Icons.delete_sweep,
                      label: 'Tout effacer',
                      color: Colors.red.shade700,
                      onPressed: _nodes.isNotEmpty ? _clearAll : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            elevation: 8,
          ),
          child: Icon(icon, size: 28),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
