import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/localization_service.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';

/// Widget de sélection de langue
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Provider.of<LocalizationService>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: LocalizationService.supportedLocales.map((locale) {
        final isSelected = localizationService.locale == locale;
        return Card(
          margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
          color: isSelected ? AppColors.savanna.withOpacity(0.2) : null,
          child: ListTile(
            leading: Text(
              localizationService.getLanguageFlag(locale.languageCode),
              style: const TextStyle(fontSize: 32),
            ),
            title: Text(
              localizationService.getLanguageName(locale.languageCode),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
            trailing: isSelected
                ? const Icon(
                    Icons.check_circle,
                    color: AppColors.terracotta,
                  )
                : null,
            onTap: () {
              localizationService.changeLocale(locale);
            },
          ),
        );
      }).toList(),
    );
  }
}
