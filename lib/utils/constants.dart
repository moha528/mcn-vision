/// Constantes de l'application
class AppConstants {
  // Informations de l'application
  static const String appName = 'MCN Vision';
  static const String appVersion = '1.0.0';

  // Routes
  static const String homeRoute = '/';
  static const String artworksRoute = '/artworks';
  static const String artworkDetailRoute = '/artwork';
  static const String qrScannerRoute = '/qr-scan';
  static const String arRoute = '/ar';
  static const String vrRoute = '/vr';
  static const String settingsRoute = '/settings';

  // Clés de stockage local
  static const String languageKey = 'selected_language';
  static const String themeKey = 'selected_theme';

  // Langues supportées
  static const String frenchCode = 'fr';
  static const String englishCode = 'en';
  static const String wolofCode = 'wo';

  // Époques pour les filtres
  static const List<String> epochs = [
    'Préhistoire',
    'Antiquité',
    'Moyen Âge',
    'Renaissance',
    'Époque moderne',
    'Époque contemporaine',
  ];

  // Types d'œuvres
  static const List<String> artworkTypes = [
    'Peinture',
    'Sculpture',
    'Photographie',
    'Artisanat',
    'Textile',
    'Céramique',
    'Bijoux',
    'Autre',
  ];

  // Origines/Régions
  static const List<String> regions = [
    'Afrique de l\'Ouest',
    'Afrique de l\'Est',
    'Afrique du Nord',
    'Afrique centrale',
    'Afrique australe',
  ];

  // Animation
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Espacements
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;

  // Tailles d'icônes
  static const double iconSmall = 20.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;

  // Formats de médias supportés
  static const List<String> audioFormats = ['mp3', 'wav', 'aac', 'm4a'];
  static const List<String> videoFormats = ['mp4', 'mov', 'avi', 'mkv'];
  static const List<String> imageFormats = ['jpg', 'jpeg', 'png', 'webp', 'svg'];
}
