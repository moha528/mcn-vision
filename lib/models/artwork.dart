/// Modèle représentant une œuvre d'art
class Artwork {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? audioUrl;
  final String? videoUrl;
  final String epoch; // Époque
  final String origin; // Origine/Région
  final String type; // Type d'œuvre
  final String qrCode; // Code QR associé
  final List<String> tags; // Tags pour la recherche
  final DateTime? creationDate;
  final String? artist;
  final Map<String, String>? translatedTitles; // Titres traduits
  final Map<String, String>? translatedDescriptions; // Descriptions traduites

  Artwork({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.audioUrl,
    this.videoUrl,
    required this.epoch,
    required this.origin,
    required this.type,
    required this.qrCode,
    this.tags = const [],
    this.creationDate,
    this.artist,
    this.translatedTitles,
    this.translatedDescriptions,
  });

  /// Récupère le titre traduit selon la langue
  String getTitleForLocale(String languageCode) {
    if (translatedTitles != null && translatedTitles!.containsKey(languageCode)) {
      return translatedTitles![languageCode]!;
    }
    return title;
  }

  /// Récupère la description traduite selon la langue
  String getDescriptionForLocale(String languageCode) {
    if (translatedDescriptions != null &&
        translatedDescriptions!.containsKey(languageCode)) {
      return translatedDescriptions![languageCode]!;
    }
    return description;
  }

  /// Vérifie si l'œuvre a un guide audio
  bool get hasAudioGuide => audioUrl != null && audioUrl!.isNotEmpty;

  /// Vérifie si l'œuvre a une vidéo
  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;

  /// Conversion depuis JSON
  factory Artwork.fromJson(Map<String, dynamic> json) {
    return Artwork(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      audioUrl: json['audioUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      epoch: json['epoch'] as String,
      origin: json['origin'] as String,
      type: json['type'] as String,
      qrCode: json['qrCode'] as String,
      tags: json['tags'] != null
          ? List<String>.from(json['tags'] as List)
          : [],
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'] as String)
          : null,
      artist: json['artist'] as String?,
      translatedTitles: json['translatedTitles'] != null
          ? Map<String, String>.from(json['translatedTitles'] as Map)
          : null,
      translatedDescriptions: json['translatedDescriptions'] != null
          ? Map<String, String>.from(json['translatedDescriptions'] as Map)
          : null,
    );
  }

  /// Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'videoUrl': videoUrl,
      'epoch': epoch,
      'origin': origin,
      'type': type,
      'qrCode': qrCode,
      'tags': tags,
      'creationDate': creationDate?.toIso8601String(),
      'artist': artist,
      'translatedTitles': translatedTitles,
      'translatedDescriptions': translatedDescriptions,
    };
  }

  /// Crée une copie de l'œuvre avec des modifications
  Artwork copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? audioUrl,
    String? videoUrl,
    String? epoch,
    String? origin,
    String? type,
    String? qrCode,
    List<String>? tags,
    DateTime? creationDate,
    String? artist,
    Map<String, String>? translatedTitles,
    Map<String, String>? translatedDescriptions,
  }) {
    return Artwork(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      epoch: epoch ?? this.epoch,
      origin: origin ?? this.origin,
      type: type ?? this.type,
      qrCode: qrCode ?? this.qrCode,
      tags: tags ?? this.tags,
      creationDate: creationDate ?? this.creationDate,
      artist: artist ?? this.artist,
      translatedTitles: translatedTitles ?? this.translatedTitles,
      translatedDescriptions:
          translatedDescriptions ?? this.translatedDescriptions,
    );
  }
}
