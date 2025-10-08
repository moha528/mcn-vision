import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Gestion des traductions de l'application
class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// Charge les traductions depuis le fichier JSON
  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('assets/l10n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  /// Récupère une traduction par clé
  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Méthodes d'accès rapide aux traductions
  String get appName => translate('app_name');
  String get home => translate('home');
  String get artworks => translate('artworks');
  String get qrScanner => translate('qr_scanner');
  String get augmentedReality => translate('augmented_reality');
  String get virtualReality => translate('virtual_reality');
  String get settings => translate('settings');
  String get explore => translate('explore');
  String get search => translate('search');
  String get filter => translate('filter');
  String get all => translate('all');
  String get epoch => translate('epoch');
  String get type => translate('type');
  String get origin => translate('origin');
  String get details => translate('details');
  String get description => translate('description');
  String get audioGuide => translate('audio_guide');
  String get video => translate('video');
  String get scanQR => translate('scan_qr');
  String get scanQRDescription => translate('scan_qr_description');
  String get scanningInProgress => translate('scanning_in_progress');
  String get arComingSoon => translate('ar_coming_soon');
  String get vrComingSoon => translate('vr_coming_soon');
  String get arDescription => translate('ar_description');
  String get vrDescription => translate('vr_description');
  String get language => translate('language');
  String get french => translate('french');
  String get english => translate('english');
  String get wolof => translate('wolof');
  String get about => translate('about');
  String get version => translate('version');
  String get noArtworks => translate('no_artworks');
  String get searchArtworks => translate('search_artworks');
  String get applyFilters => translate('apply_filters');
  String get clearFilters => translate('clear_filters');
  String get play => translate('play');
  String get pause => translate('pause');
  String get stop => translate('stop');
  String get loading => translate('loading');
  String get error => translate('error');
  String get retry => translate('retry');
  String get close => translate('close');
  String get cancel => translate('cancel');
  String get ok => translate('ok');
  String get welcomeMessage => translate('welcome_message');
  String get exploreCollection => translate('explore_collection');
  String get scanArtwork => translate('scan_artwork');
  String get experienceAR => translate('experience_ar');
  String get experienceVR => translate('experience_vr');
  String get homeTab => translate('home_tab');
  String get collectionTab => translate('collection_tab');
  String get scannerTab => translate('scanner_tab');
  String get settingsTab => translate('settings_tab');
  String get discoverOurCollection => translate('discover_our_collection');
  String get viewAll => translate('view_all');
  String get scanNow => translate('scan_now');
  String get recentArtworks => translate('recent_artworks');
  String get comingSoon => translate('coming_soon');
  String get featuresComingSoon => translate('features_coming_soon');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['fr', 'en', 'wo'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
