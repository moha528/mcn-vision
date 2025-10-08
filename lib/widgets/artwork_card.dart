import 'package:flutter/material.dart';
import '../models/artwork.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

/// Carte d'œuvre d'art pour l'affichage en liste
class ArtworkCard extends StatelessWidget {
  final Artwork artwork;
  final VoidCallback onTap;
  final String languageCode;

  const ArtworkCard({
    super.key,
    required this.artwork,
    required this.onTap,
    this.languageCode = 'fr',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Hero(
              tag: 'artwork_${artwork.id}',
              child: Image.asset(
                artwork.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: AppColors.lightSand,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: AppConstants.iconXLarge,
                        color: AppColors.terracotta,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Image non disponible',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Contenu
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  Text(
                    artwork.getTitleForLocale(languageCode),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),

                  // Époque et origine
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        size: AppConstants.iconSmall,
                        color: AppColors.terracotta,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          artwork.epoch,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: AppConstants.iconSmall,
                        color: AppColors.emerald,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          artwork.origin,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),

                  // Type
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.savanna.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                    ),
                    child: Text(
                      artwork.type,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.baobab,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),

                  // Indicateurs audio/vidéo
                  Row(
                    children: [
                      if (artwork.hasAudioGuide)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.headphones,
                                size: AppConstants.iconSmall,
                                color: AppColors.indigo,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Audio',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      if (artwork.hasVideo)
                        Row(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              size: AppConstants.iconSmall,
                              color: AppColors.sunset,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Vidéo',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
