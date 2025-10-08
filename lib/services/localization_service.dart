import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

/// Service de gestion de la localisation
class LocalizationService extends ChangeNotifier {
  Locale _locale = const Locale('fr');

  Locale get locale => _locale;

  /// Langues supportées
  static const List<Locale> supportedLocales = [
    Locale('fr'), // Français
    Locale('en'), // Anglais
    Locale('wo'), // Wolof
  ];

  /// Change la langue de l'application
  Future<void> changeLocale(Locale newLocale) async {
    if (!supportedLocales.contains(newLocale)) return;

    _locale = newLocale;
    notifyListeners();

    // Sauvegarder la préférence
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.languageKey, newLocale.languageCode);
  }

  /// Charge la langue sauvegardée
  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(AppConstants.languageKey);

    if (languageCode != null) {
      final savedLocale = Locale(languageCode);
      if (supportedLocales.contains(savedLocale)) {
        _locale = savedLocale;
        notifyListeners();
      }
    }
  }

  /// Récupère le nom de la langue en fonction du code
  String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      case 'wo':
        return 'Wolof';
      default:
        return languageCode;
    }
  }

  /// Récupère le drapeau emoji en fonction du code de langue
  String getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return '🇫🇷';
      case 'en':
        return '🇬🇧';
      case 'wo':
        return '🇸🇳'; // Sénégal pour le Wolof
      default:
        return '🌍';
    }
  }
}
