import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';
import '../widgets/language_selector.dart';

/// Écran des paramètres
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // En-tête
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Text(
                localizations.settingsTab,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.terracotta,
                    ),
              ),
            ),
          // Section langue
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: AppColors.terracotta,
                      size: AppConstants.iconLarge,
                    ),
                    const SizedBox(width: AppConstants.paddingMedium),
                    Text(
                      localizations.language,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                const LanguageSelector(),
              ],
            ),
          ),

          const Divider(height: 32),

          // Section à propos
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.terracotta,
                      size: AppConstants.iconLarge,
                    ),
                    const SizedBox(width: AppConstants.paddingMedium),
                    Text(
                      localizations.about,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.museum,
                            color: AppColors.savanna,
                          ),
                          title: Text(
                            localizations.appName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          subtitle: Text(
                            '${localizations.version} ${AppConstants.appVersion}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(AppConstants.paddingMedium),
                          child: Text(
                            'Application mobile du Musée des Civilisations dédiée à '
                            'l\'exploration des richesses culturelles africaines.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 32),

          // Fonctionnalités à venir
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.rocket_launch,
                      color: AppColors.terracotta,
                      size: AppConstants.iconLarge,
                    ),
                    const SizedBox(width: AppConstants.paddingMedium),
                    Text(
                      localizations.featuresComingSoon,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                Card(
                  child: Column(
                    children: [
                      _ComingSoonFeatureTile(
                        icon: Icons.view_in_ar,
                        title: localizations.augmentedReality,
                        description: 'Visualisez les œuvres en 3D dans votre espace',
                        color: AppColors.emerald,
                      ),
                      const Divider(height: 1),
                      _ComingSoonFeatureTile(
                        icon: Icons.vrpano,
                        title: localizations.virtualReality,
                        description: 'Visitez le musée en réalité virtuelle',
                        color: AppColors.indigo,
                      ),
                    ],
                  ),
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

/// Widget pour les fonctionnalités à venir
class _ComingSoonFeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _ComingSoonFeatureTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: color,
          size: AppConstants.iconLarge,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.savanna.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.savanna.withOpacity(0.5),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.comingSoon,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.savanna,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ),
    );
  }
}

