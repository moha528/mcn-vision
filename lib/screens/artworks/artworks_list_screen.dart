import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../services/artwork_service.dart';
import '../../services/localization_service.dart';
import '../../utils/app_theme.dart';
import '../../utils/constants.dart';
import '../../widgets/artwork_card.dart';

/// Écran de liste des œuvres avec recherche et filtres
class ArtworksListScreen extends StatefulWidget {
  const ArtworksListScreen({super.key});

  @override
  State<ArtworksListScreen> createState() => _ArtworksListScreenState();
}

class _ArtworksListScreenState extends State<ArtworksListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog(BuildContext context) {
    final artworkService = Provider.of<ArtworkService>(context, listen: false);
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.filter),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filtre par époque
                  Text(
                    localizations.epoch,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(localizations.all),
                        selected: artworkService.selectedEpoch == null,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              artworkService.filterByEpoch(null);
                            });
                          }
                        },
                      ),
                      ...artworkService.getAvailableEpochs().map((epoch) {
                        return ChoiceChip(
                          label: Text(epoch),
                          selected: artworkService.selectedEpoch == epoch,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                artworkService.filterByEpoch(epoch);
                              });
                            }
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),

                  // Filtre par type
                  Text(
                    localizations.type,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(localizations.all),
                        selected: artworkService.selectedType == null,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              artworkService.filterByType(null);
                            });
                          }
                        },
                      ),
                      ...artworkService.getAvailableTypes().map((type) {
                        return ChoiceChip(
                          label: Text(type),
                          selected: artworkService.selectedType == type,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                artworkService.filterByType(type);
                              });
                            }
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),

                  // Filtre par origine
                  Text(
                    localizations.origin,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(localizations.all),
                        selected: artworkService.selectedOrigin == null,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              artworkService.filterByOrigin(null);
                            });
                          }
                        },
                      ),
                      ...artworkService.getAvailableOrigins().map((origin) {
                        return ChoiceChip(
                          label: Text(origin),
                          selected: artworkService.selectedOrigin == origin,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                artworkService.filterByOrigin(origin);
                              });
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              artworkService.clearFilters();
              Navigator.pop(context);
            },
            child: Text(localizations.clearFilters),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final artworkService = Provider.of<ArtworkService>(context);
    final localizationService = Provider.of<LocalizationService>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // En-tête avec titre et bouton filtres
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      localizations.collectionTab,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.terracotta,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_alt_outlined),
                    onPressed: () => _showFilterDialog(context),
                  ),
                ],
              ),
            ),

            // Barre de recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: localizations.searchArtworks,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            artworkService.searchArtworks('');
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  artworkService.searchArtworks(value);
                },
              ),
            ),

          // Indicateur de filtres actifs
          if (artworkService.selectedEpoch != null ||
              artworkService.selectedType != null ||
              artworkService.selectedOrigin != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingMedium,
                vertical: AppConstants.paddingSmall,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (artworkService.selectedEpoch != null)
                          Chip(
                            label: Text(artworkService.selectedEpoch!),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () => artworkService.filterByEpoch(null),
                          ),
                        if (artworkService.selectedType != null)
                          Chip(
                            label: Text(artworkService.selectedType!),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () => artworkService.filterByType(null),
                          ),
                        if (artworkService.selectedOrigin != null)
                          Chip(
                            label: Text(artworkService.selectedOrigin!),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () => artworkService.filterByOrigin(null),
                          ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => artworkService.clearFilters(),
                    child: Text(localizations.clearFilters),
                  ),
                ],
              ),
            ),

          // Liste des œuvres
          Expanded(
            child: artworkService.artworks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.terracotta.withOpacity(0.5),
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        Text(
                          localizations.noArtworks,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    itemCount: artworkService.artworks.length,
                    itemBuilder: (context, index) {
                      final artwork = artworkService.artworks[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppConstants.paddingMedium,
                        ),
                        child: ArtworkCard(
                          artwork: artwork,
                          languageCode: localizationService.locale.languageCode,
                          onTap: () {
                            context.push(
                              '${AppConstants.artworkDetailRoute}/${artwork.id}',
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      ),
    );
  }
}
