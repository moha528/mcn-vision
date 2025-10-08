import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

/// Écran de réalité virtuelle
class VRScreen extends StatelessWidget {
  const VRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.virtualReality),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingXLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icône VR
                Container(
                  padding: const EdgeInsets.all(AppConstants.paddingXLarge),
                  decoration: BoxDecoration(
                    color: AppColors.indigo.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.vrpano,
                    size: 120,
                    color: AppColors.indigo,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingXLarge),

                // Titre
                Text(
                  localizations.virtualReality,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.indigo,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.paddingMedium),

                // Description
                Text(
                  localizations.vrDescription,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.paddingXLarge),

                // Placeholder pour future implémentation
                Container(
                  padding: const EdgeInsets.all(AppConstants.paddingLarge),
                  decoration: BoxDecoration(
                    color: AppColors.lightSand,
                    borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                    border: Border.all(
                      color: AppColors.indigo.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.construction,
                        size: AppConstants.iconXLarge,
                        color: AppColors.indigo,
                      ),
                      const SizedBox(height: AppConstants.paddingMedium),
                      Text(
                        'Fonctionnalité en cours de développement',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppConstants.paddingSmall),
                      Text(
                        'L\'expérience VR sera bientôt disponible pour visiter le musée en immersion totale',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
