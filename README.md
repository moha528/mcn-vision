# 🏛️ MCN Vision - Application Mobile du Musée

Application mobile moderne dédiée à l'exploration des richesses culturelles africaines du Musée des Civilisations.

## ✨ Fonctionnalités

### ✅ Implémentées
- **Exploration de la collection** : Parcourez les œuvres d'art avec images, descriptions et métadonnées
- **Recherche et filtres** : Recherche par mot-clé et filtrage par époque, type et origine
- **Scanner QR** : Scannez les QR codes des œuvres pour accéder instantanément à leurs fiches
- **Multilingue** : Support complet du Français, Anglais et Wolof
- **Fiches détaillées** : Informations complètes sur chaque œuvre avec support audio/vidéo (à implémenter)

### 🚧 À venir
- **Réalité Augmentée (AR)** : Visualisation des œuvres en 3D dans votre espace
- **Réalité Virtuelle (VR)** : Visite virtuelle immersive du musée
- **Lecteurs audio/vidéo** : Guides audio et vidéos intégrés

## 🎨 Design

L'application utilise une palette de couleurs inspirée de l'Afrique :
- Terre cuite (`#D2691E`)
- Or/Savane (`#E8A735`)
- Vert émeraude (`#2E8B57`)
- Indigo africain (`#4B0082`)

## 📱 Structure du projet

```
lib/
├── l10n/                  # Traductions (FR, EN, WO)
├── models/                # Modèles de données (Artwork)
├── screens/               # Écrans de l'application
│   ├── artworks/         # Liste et détail des œuvres
│   ├── home_screen.dart  # Écran d'accueil
│   ├── qr_scanner_screen.dart
│   ├── ar_screen.dart    # Placeholder AR
│   ├── vr_screen.dart    # Placeholder VR
│   └── settings_screen.dart
├── services/              # Services (données, localisation)
├── utils/                 # Utilitaires (thème, constantes, router)
├── widgets/               # Widgets réutilisables
└── main.dart             # Point d'entrée

assets/
├── images/               # Images des œuvres
├── audio/                # Guides audio
└── l10n/                 # Fichiers JSON de traduction
```

## 🚀 Installation et lancement

### Prérequis
- Flutter SDK (version 3.9.2 ou supérieure)
- Android Studio / Xcode pour les émulateurs
- Un éditeur (VS Code, Android Studio, etc.)

### Installation des dépendances
```bash
flutter pub get
```

### Lancement de l'application
```bash
# Mode développement
flutter run

# Spécifier un device
flutter run -d chrome
flutter run -d android
flutter run -d ios
```

### Build de production
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📦 Dépendances principales

- **go_router** (^14.6.2) : Navigation
- **provider** (^6.1.2) : Gestion d'état
- **mobile_scanner** (^5.2.3) : Scanner QR
- **cached_network_image** (^3.4.1) : Gestion des images
- **audioplayers** (^6.1.0) : Lecture audio
- **video_player** (^2.9.2) : Lecture vidéo
- **shared_preferences** (^2.3.3) : Stockage local

## 🌍 Langues supportées

- 🇫🇷 Français
- 🇬🇧 Anglais
- 🇸🇳 Wolof

## 📚 Données mockées

L'application contient 6 œuvres d'art mockées pour la démonstration :
1. Masque Dogon (Mali)
2. Statuette Ashanti (Ghana)
3. Tissu Kente (Ghana)
4. Poterie Berbère (Maroc)
5. Masque Fang (Gabon)
6. Tabouret Baoulé (Côte d'Ivoire)

## 🔧 Configuration

### Permissions requises

**Android** (`android/app/src/main/AndroidManifest.xml`) :
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.INTERNET" />
```

**iOS** (`ios/Runner/Info.plist`) :
```xml
<key>NSCameraUsageDescription</key>
<string>Cette application nécessite l'accès à la caméra pour scanner les QR codes</string>
```

## 🎯 Prochaines étapes

1. **Implémenter les lecteurs audio/vidéo**
   - Intégration complète de audioplayers
   - Player vidéo avec contrôles

2. **Ajouter la persistance locale**
   - Cache des œuvres favorites
   - Historique de navigation

3. **Intégrer une API backend**
   - Remplacer les données mockées
   - Synchronisation des contenus

4. **Implémenter AR**
   - Intégration ARCore/ARKit
   - Modèles 3D des œuvres

5. **Implémenter VR**
   - Visite virtuelle 360°
   - Support des casques VR

## 👨‍💻 Développement

### Ajouter une nouvelle œuvre

Modifiez `lib/services/artwork_service.dart` :

```dart
Artwork(
  id: '7',
  title: 'Nouvelle Œuvre',
  description: 'Description...',
  imageUrl: 'URL_IMAGE',
  epoch: 'Époque',
  origin: 'Origine',
  type: 'Type',
  qrCode: 'ARTWORK_007',
  tags: ['tag1', 'tag2'],
  translatedTitles: {
    'fr': 'Titre FR',
    'en': 'Title EN',
    'wo': 'Titre WO',
  },
  translatedDescriptions: {
    'fr': 'Description FR',
    'en': 'Description EN',
    'wo': 'Description WO',
  },
),
```

### Ajouter une traduction

1. Modifiez les fichiers JSON dans `assets/l10n/`
2. Ajoutez les getters dans `lib/l10n/app_localizations.dart`
3. Utilisez `AppLocalizations.of(context)!.votreCle`

## 📄 Licence

Ce projet est un prototype éducatif pour le Musée des Civilisations.

## 🤝 Contribution

Pour contribuer au projet :
1. Fork le repository
2. Créez une branche (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## 📧 Contact

Pour toute question concernant le projet, veuillez contacter l'équipe de développement.

---

**Version:** 1.0.0
**Dernière mise à jour:** 2025
