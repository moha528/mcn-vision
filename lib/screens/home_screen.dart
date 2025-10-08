import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/artwork_service.dart';
import '../services/localization_service.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';
import '../widgets/artwork_card.dart';

/// Écran d'accueil moderne et simplifié
class HomeScreen extends StatelessWidget {
  final void Function(int)? onNavigateToTab;

  const HomeScreen({super.key, this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final artworkService = Provider.of<ArtworkService>(context);
    final localizationService = Provider.of<LocalizationService>(context);

    // Prendre les 3 premières œuvres pour l'affichage
    final recentArtworks = artworkService.artworks.take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConstants.paddingXLarge),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.terracotta,
                      AppColors.savanna,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.museum,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),
                    Text(
                      localizations.welcomeMessage,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.paddingSmall),
                    Text(
                      'Explorez les trésors de l\'Afrique',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Section "Découvrez notre collection"
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizations.discoverOurCollection,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.terracotta,
                              ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // Naviguer vers l'onglet collection (index 1)
                            onNavigateToTab?.call(1);
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: Text(localizations.viewAll),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),

                    // Scroll horizontal des œuvres récentes
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recentArtworks.length,
                        itemBuilder: (context, index) {
                          final artwork = recentArtworks[index];
                          return Container(
                            width: 280,
                            margin: const EdgeInsets.only(
                              right: AppConstants.paddingMedium,
                            ),
                            child: ArtworkCard(
                              artwork: artwork,
                              languageCode: localizationService.locale.languageCode,
                              onTap: () {
                                context.push(
                                  '${AppConstants.artworkDetailRoute}/${artwork.id}',
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Bouton d'action principal
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingLarge,
                  vertical: AppConstants.paddingMedium,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Naviguer vers l'onglet collection (index 1)
                      onNavigateToTab?.call(1);
                    },
                    icon: const Icon(Icons.collections, size: 28),
                    label: Text(
                      localizations.exploreCollection,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.savanna,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                      ),
                      elevation: 4,
                    ),
                  ),
                ),
              ),

              // Section "Fonctionnalités"
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fonctionnalités',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.terracotta,
                          ),
                    ),
                    const SizedBox(height: AppConstants.paddingMedium),

                    // Carte Scanner QR
                    Card(
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.savanna.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.qr_code_scanner,
                            color: AppColors.savanna,
                            size: 32,
                          ),
                        ),
                        title: Text(
                          localizations.scanArtwork,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Scannez le QR code d\'une œuvre',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Naviguer vers l'onglet scanner (index 2)
                          onNavigateToTab?.call(2);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
