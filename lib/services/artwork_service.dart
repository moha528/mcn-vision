import 'package:flutter/foundation.dart';
import '../models/artwork.dart';

/// Service de gestion des œuvres d'art
class ArtworkService extends ChangeNotifier {
  List<Artwork> _artworks = [];
  List<Artwork> _filteredArtworks = [];
  String _searchQuery = '';
  String? _selectedEpoch;
  String? _selectedType;
  String? _selectedOrigin;

  ArtworkService() {
    _loadMockArtworks();
    _filteredArtworks = _artworks;
  }

  List<Artwork> get artworks => _filteredArtworks;
  String get searchQuery => _searchQuery;
  String? get selectedEpoch => _selectedEpoch;
  String? get selectedType => _selectedType;
  String? get selectedOrigin => _selectedOrigin;

  /// Charge les œuvres de la collection
  void _loadMockArtworks() {
    _artworks = [
      Artwork(
        id: '1',
        title: 'Armure du chasseur Dogon',
        description:
            'Armure traditionnelle portée par les chasseurs du peuple Dogon au Mali. Cette armure témoigne des techniques de protection développées par cette civilisation ancestrale.',
        imageUrl: 'assets/images/Armure_du_chasseur_Dogon.jpg',
        epoch: 'Époque moderne',
        origin: 'Afrique de l\'Ouest',
        type: 'Artisanat',
        qrCode: 'ARTWORK_001',
        tags: ['dogon', 'mali', 'armure', 'chasse', 'protection'],
        artist: 'Artisan Dogon',
        translatedTitles: {
          'fr': 'Armure du chasseur Dogon',
          'en': 'Dogon Hunter\'s Armor',
          'wo': 'Armure bu njool Dogon',
        },
        translatedDescriptions: {
          'fr': 'Armure traditionnelle portée par les chasseurs du peuple Dogon au Mali. Cette armure témoigne des techniques de protection développées par cette civilisation ancestrale.',
          'en': 'Traditional armor worn by hunters of the Dogon people in Mali. This armor testifies to the protection techniques developed by this ancestral civilization.',
          'wo': 'Armure bu njëkk bu def ci njool yi ci Dogon yi ci Mali. Armure bii di waññi technique protection bu dëkk-maar yi nekk.',
        },
      ),
      Artwork(
        id: '2',
        title: 'Babouches de Serigne Babacar Sy',
        description:
            'Babouches traditionnelles ayant appartenu à Serigne Babacar Sy, figure religieuse majeure du Sénégal. Ces chaussures symbolisent le statut spirituel et social de leur propriétaire.',
        imageUrl: 'assets/images/Babouches_Serigne_Babacar_Sy.jpg',
        epoch: 'Époque contemporaine',
        origin: 'Afrique de l\'Ouest',
        type: 'Textile',
        qrCode: 'ARTWORK_002',
        tags: ['sénégal', 'babouches', 'religion', 'serigne', 'spiritualité'],
        artist: 'Artisan sénégalais',
        translatedTitles: {
          'fr': 'Babouches de Serigne Babacar Sy',
          'en': 'Serigne Babacar Sy\'s Slippers',
          'wo': 'Babouches Serigne Babacar Sy',
        },
        translatedDescriptions: {
          'fr': 'Babouches traditionnelles ayant appartenu à Serigne Babacar Sy, figure religieuse majeure du Sénégal. Ces chaussures symbolisent le statut spirituel et social de leur propriétaire.',
          'en': 'Traditional slippers that belonged to Serigne Babacar Sy, a major religious figure in Senegal. These shoes symbolize the spiritual and social status of their owner.',
          'wo': 'Babouches bu njëkk bu am Serigne Babacar Sy, kii moo nekk boroom jamonoy bu mag ci Senegaal. Babouches yi di alaamat jikko spiritual ak social bu boroom.',
        },
      ),
      Artwork(
        id: '3',
        title: 'Plaque Oba Oguola',
        description:
            'Plaque commémorative en bronze du royaume du Bénin représentant l\'Oba Oguola (16e siècle). Ces plaques ornaient les murs du palais royal et témoignent de la maîtrise artistique des bronziers béninois.',
        imageUrl: 'assets/images/Oba_Oguola.jpg',
        epoch: 'Renaissance',
        origin: 'Afrique de l\'Ouest',
        type: 'Sculpture',
        qrCode: 'ARTWORK_003',
        tags: ['bénin', 'bronze', 'oba', 'royauté', 'royaume'],
        artist: 'Bronziers du Bénin',
        creationDate: DateTime(1550),
        translatedTitles: {
          'fr': 'Plaque Oba Oguola',
          'en': 'Oba Oguola Plaque',
          'wo': 'Plaque Oba Oguola',
        },
        translatedDescriptions: {
          'fr': 'Plaque commémorative en bronze du royaume du Bénin représentant l\'Oba Oguola (16e siècle). Ces plaques ornaient les murs du palais royal et témoignent de la maîtrise artistique des bronziers béninois.',
          'en': 'Bronze commemorative plaque from the Kingdom of Benin depicting Oba Oguola (16th century). These plaques adorned the walls of the royal palace and testify to the artistic mastery of Benin bronze casters.',
          'wo': 'Plaque bu bronze bu souvenir ci royaume Bénin yi, mu waññi Oba Oguola (16e siècle). Plaque yi dañuy jëkk nga palais royal bi te dañu waññi xam-xam liggéey yi ci bronziers Bénin yi.',
        },
      ),
      Artwork(
        id: '4',
        title: 'Plaque Oba Ozolua',
        description:
            'Représentation en bronze de l\'Oba Ozolua (fin 15e siècle), souverain guerrier du royaume du Bénin. Cette plaque illustre la puissance militaire et la sophistication artistique de l\'empire.',
        imageUrl: 'assets/images/Oba_Ozolua.jpg',
        epoch: 'Renaissance',
        origin: 'Afrique de l\'Ouest',
        type: 'Sculpture',
        qrCode: 'ARTWORK_004',
        tags: ['bénin', 'bronze', 'oba', 'guerrier', 'empire'],
        artist: 'Bronziers du Bénin',
        creationDate: DateTime(1480),
        translatedTitles: {
          'fr': 'Plaque Oba Ozolua',
          'en': 'Oba Ozolua Plaque',
          'wo': 'Plaque Oba Ozolua',
        },
        translatedDescriptions: {
          'fr': 'Représentation en bronze de l\'Oba Ozolua (fin 15e siècle), souverain guerrier du royaume du Bénin. Cette plaque illustre la puissance militaire et la sophistication artistique de l\'empire.',
          'en': 'Bronze representation of Oba Ozolua (late 15th century), warrior king of the Kingdom of Benin. This plaque illustrates the military power and artistic sophistication of the empire.',
          'wo': 'Waññi ci bronze Oba Ozolua (fin 15e siècle), boroom-jaar ci royaume Bénin. Plaque bii di waññi doole militaire ak sophistication liggéey ci empire bi.',
        },
      ),
      Artwork(
        id: '5',
        title: 'Ovonramwen Nogbaisi sur le chemin de l\'exil',
        description:
            'Photographie historique (1897) du dernier Oba indépendant du Bénin, Ovonramwen Nogbaisi, durant son exil forcé par les Britanniques. Document rare témoignant de la fin du royaume indépendant du Bénin.',
        imageUrl: 'assets/images/Ovonramwen_Nogbaisi_sur_le_chemin_de_l\'exil.jpg',
        epoch: 'Époque moderne',
        origin: 'Afrique de l\'Ouest',
        type: 'Photographie',
        qrCode: 'ARTWORK_005',
        tags: ['bénin', 'photographie', 'oba', 'exil', 'colonisation', 'histoire'],
        artist: 'Photographe britannique',
        creationDate: DateTime(1897),
        translatedTitles: {
          'fr': 'Ovonramwen Nogbaisi sur le chemin de l\'exil',
          'en': 'Ovonramwen Nogbaisi on the Path to Exile',
          'wo': 'Ovonramwen Nogbaisi ci yoon exil bi',
        },
        translatedDescriptions: {
          'fr': 'Photographie historique (1897) du dernier Oba indépendant du Bénin, Ovonramwen Nogbaisi, durant son exil forcé par les Britanniques. Document rare témoignant de la fin du royaume indépendant du Bénin.',
          'en': 'Historical photograph (1897) of the last independent Oba of Benin, Ovonramwen Nogbaisi, during his forced exile by the British. Rare document witnessing the end of the independent Kingdom of Benin.',
          'wo': 'Photo historique (1897) ci Oba bu mujj indépendant bi ci Bénin, Ovonramwen Nogbaisi, ci jamono exil bu Britannique yi jagleel. Document bu amul laaj mu waññi jeexitaay royaume indépendant bi ci Bénin.',
        },
      ),
    ];
  }

  /// Recherche des œuvres par mot-clé
  void searchArtworks(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  /// Filtre par époque
  void filterByEpoch(String? epoch) {
    _selectedEpoch = epoch;
    _applyFilters();
  }

  /// Filtre par type
  void filterByType(String? type) {
    _selectedType = type;
    _applyFilters();
  }

  /// Filtre par origine
  void filterByOrigin(String? origin) {
    _selectedOrigin = origin;
    _applyFilters();
  }

  /// Efface tous les filtres
  void clearFilters() {
    _searchQuery = '';
    _selectedEpoch = null;
    _selectedType = null;
    _selectedOrigin = null;
    _applyFilters();
  }

  /// Applique les filtres
  void _applyFilters() {
    _filteredArtworks = _artworks.where((artwork) {
      // Filtre de recherche
      if (_searchQuery.isNotEmpty) {
        final matchesSearch = artwork.title.toLowerCase().contains(_searchQuery) ||
            artwork.description.toLowerCase().contains(_searchQuery) ||
            artwork.tags.any((tag) => tag.toLowerCase().contains(_searchQuery));
        if (!matchesSearch) return false;
      }

      // Filtre par époque
      if (_selectedEpoch != null && artwork.epoch != _selectedEpoch) {
        return false;
      }

      // Filtre par type
      if (_selectedType != null && artwork.type != _selectedType) {
        return false;
      }

      // Filtre par origine
      if (_selectedOrigin != null && artwork.origin != _selectedOrigin) {
        return false;
      }

      return true;
    }).toList();

    notifyListeners();
  }

  /// Récupère une œuvre par son ID
  Artwork? getArtworkById(String id) {
    try {
      return _artworks.firstWhere((artwork) => artwork.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Récupère une œuvre par son QR code
  Artwork? getArtworkByQRCode(String qrCode) {
    try {
      return _artworks.firstWhere((artwork) => artwork.qrCode == qrCode);
    } catch (e) {
      return null;
    }
  }

  /// Récupère toutes les époques disponibles
  List<String> getAvailableEpochs() {
    return _artworks.map((artwork) => artwork.epoch).toSet().toList()..sort();
  }

  /// Récupère tous les types disponibles
  List<String> getAvailableTypes() {
    return _artworks.map((artwork) => artwork.type).toSet().toList()..sort();
  }

  /// Récupère toutes les origines disponibles
  List<String> getAvailableOrigins() {
    return _artworks.map((artwork) => artwork.origin).toSet().toList()..sort();
  }
}
