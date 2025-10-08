# Assets - MCN Vision

## Structure des dossiers

- `images/` - Images des œuvres d'art et autres ressources visuelles
- `audio/` - Fichiers audio pour les guides audio des œuvres
- `l10n/` - Fichiers de traduction (JSON)

## Images placeholder

Pour le prototype, les images des œuvres utilisent des URLs placeholder de type:
- `https://via.placeholder.com/400x300/[couleur]/FFFFFF?text=[Nom+Oeuvre]`

## Pour la production

Remplacez les URLs placeholder par vos propres images en plaçant les fichiers dans le dossier `assets/images/` et en mettant à jour les chemins dans le service `ArtworkService`.

Exemple de structure recommandée:
```
assets/
  images/
    artworks/
      masque_dogon.jpg
      statuette_ashanti.jpg
      ...
    icons/
      app_icon.png
  audio/
    guides/
      masque_dogon_fr.mp3
      masque_dogon_en.mp3
      ...
  l10n/
    fr.json
    en.json
    wo.json
```

## Formats supportés

### Images
- JPG, JPEG, PNG, WebP, SVG

### Audio
- MP3, WAV, AAC, M4A

### Vidéo
- MP4, MOV, AVI, MKV
