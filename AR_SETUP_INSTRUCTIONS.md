# AR Resources Setup Instructions

## Overview
This document explains how to set up AR reference images in Xcode for the MCN Vision app's AR Guide mode.

## Prerequisites
- macOS with Xcode installed
- Access to the 5 artwork images in `assets/images/`

## Step-by-Step Instructions

### 1. Open the iOS Project in Xcode
```bash
cd ios
open Runner.xcworkspace
```

### 2. Create AR Resources Group
1. In Xcode's Project Navigator, select `Runner/Assets.xcassets`
2. Right-click in the asset catalog and select **New AR Resource Group**
3. Name it `AR Resources` (this name must match exactly)

### 3. Add Reference Images
For each of the 5 artwork images, do the following:

1. Click the `+` button at the bottom of the AR Resources group
2. Select **AR Reference Image**
3. Drag and drop the artwork image from `assets/images/` into the image well
4. Configure the reference image:

#### Artwork 1: Armure du chasseur Dogon
- **Name:** `ARTWORK_001` (must match exactly)
- **Image:** `Armure_du_chasseur_Dogon.jpg`
- **Physical Size:** Width: 0.2 meters (estimate the real-world size)

#### Artwork 2: Babouches de Serigne Babacar Sy
- **Name:** `ARTWORK_002`
- **Image:** `Babouches_Serigne_Babacar_Sy.jpg`
- **Physical Size:** Width: 0.15 meters

#### Artwork 3: Plaque Oba Oguola
- **Name:** `ARTWORK_003`
- **Image:** `Oba_Oguola.jpg`
- **Physical Size:** Width: 0.3 meters

#### Artwork 4: Plaque Oba Ozolua
- **Name:** `ARTWORK_004`
- **Image:** `Oba_Ozolua.jpg`
- **Physical Size:** Width: 0.3 meters

#### Artwork 5: Ovonramwen Nogbaisi sur le chemin de l'exil
- **Name:** `ARTWORK_005`
- **Image:** `Ovonramwen_Nogbaisi_sur_le_chemin_de_l'exil.jpg`
- **Physical Size:** Width: 0.25 meters

**Important Notes:**
- The **Name** field must match the `qrCode` field in the artwork data exactly
- Physical size should reflect the actual real-world size of the artwork for accurate tracking
- Adjust physical sizes based on your actual museum display dimensions

### 4. Verify Setup
1. Build and run the app on an iOS device (iOS 11.3+ required for image detection)
2. Point the camera at a printed/displayed artwork image
3. The app should detect the artwork and display AR information overlay

## Troubleshooting

### Image Not Detected
- Ensure the physical size is set correctly
- Use high-quality prints/displays of the images
- Ensure good lighting conditions
- The image should have sufficient features (avoid plain colors)

### Wrong Artwork Detected
- Verify the Name field matches the qrCode exactly
- Check that the correct image file was imported

### AR Resources Not Found
- Verify the group is named exactly `AR Resources`
- Clean build folder (Cmd+Shift+K) and rebuild

## Testing Without Physical Artworks
For testing during development, you can:
1. Display the artwork images on another device/monitor
2. Print the images on paper
3. Use the images from your computer screen (may be less reliable)

## Next Steps
After setting up AR Resources:
1. Test image detection with all 5 artworks
2. Adjust physical sizes if tracking is inaccurate
3. Test narration functionality for each artwork
