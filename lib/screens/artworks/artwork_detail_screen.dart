import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../services/artwork_service.dart';
import '../../services/localization_service.dart';
import '../../utils/app_theme.dart';
import '../../utils/constants.dart';

/// Écran de détail d'une œuvre d'art
class ArtworkDetailScreen extends StatelessWidget {
  final String artworkId;

  const ArtworkDetailScreen({
    super.key,
    required this.artworkId,
  });

  @override
  Widget build(BuildContext context) {
    final artworkService = Provider.of<ArtworkService>(context, listen: false);
    final localizationService = Provider.of<LocalizationService>(context);
    final localizations = AppLocalizations.of(context)!;
    final artwork = artworkService.getArtworkById(artworkId);

    if (artwork == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(localizations.error),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              Text(
                'Œuvre introuvable',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar avec image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                artwork.getTitleForLocale(localizationService.locale.languageCode),
                style: const TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              background: Hero(
                tag: 'artwork_${artwork.id}',
                child: CachedNetworkImage(
                  imageUrl: artwork.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.lightSand,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.lightSand,
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 64,
                      color: AppColors.terracotta,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Contenu
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Informations principales
                  Row(
                    children: [
                      Expanded(
                        child: _InfoChip(
                          icon: Icons.history,
                          label: artwork.epoch,
                          color: AppColors.terracotta,
                        ),
                      ),
                      const SizedBox(width: AppConstants.paddingSmall),
                      Expanded(
                        child: _InfoChip(
                          icon: Icons.location_on,
                          label: artwork.origin,
                          color: AppColors.emerald,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  _InfoChip(
                    icon: Icons.category,
                    label: artwork.type,
                    color: AppColors.savanna,
                  ),

                  if (artwork.artist != null) ...[
                    const SizedBox(height: AppConstants.paddingMedium),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: AppConstants.iconSmall,
                          color: AppColors.indigo,
                        ),
                        const SizedBox(width: AppConstants.paddingSmall),
                        Text(
                          artwork.artist!,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: AppConstants.paddingLarge),
                  Divider(color: AppColors.sahara),
                  const SizedBox(height: AppConstants.paddingLarge),

                  // Description
                  Text(
                    localizations.description,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.terracotta,
                        ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  Text(
                    artwork.getDescriptionForLocale(
                      localizationService.locale.languageCode,
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: AppConstants.paddingLarge),

                  // Guide audio
                  if (artwork.hasAudioGuide) ...[
                    Card(
                      color: AppColors.indigo.withOpacity(0.1),
                      child: ListTile(
                        leading: Icon(
                          Icons.headphones,
                          color: AppColors.indigo,
                          size: AppConstants.iconLarge,
                        ),
                        title: Text(
                          localizations.audioGuide,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          'Écoutez le guide audio de cette œuvre',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () {
                            // TODO: Implémenter la lecture audio
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Lecture audio à implémenter'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),
                  ],

                  // Vidéo
                  if (artwork.hasVideo) ...[
                    Card(
                      color: AppColors.sunset.withOpacity(0.1),
                      child: ListTile(
                        leading: Icon(
                          Icons.play_circle_outline,
                          color: AppColors.sunset,
                          size: AppConstants.iconLarge,
                        ),
                        title: Text(
                          localizations.video,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          'Regardez une vidéo sur cette œuvre',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () {
                            // TODO: Implémenter la lecture vidéo
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Lecture vidéo à implémenter'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),
                  ],

                  // QR Code
                  Card(
                    color: AppColors.savanna.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      child: Row(
                        children: [
                          Icon(
                            Icons.qr_code,
                            color: AppColors.savanna,
                            size: AppConstants.iconLarge,
                          ),
                          const SizedBox(width: AppConstants.paddingMedium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'QR Code',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  artwork.qrCode,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontFamily: 'monospace',
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Chip d'information
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppConstants.iconSmall,
            color: color,
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
