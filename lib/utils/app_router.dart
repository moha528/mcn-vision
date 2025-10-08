import 'package:go_router/go_router.dart';
import '../screens/artworks/artwork_detail_screen.dart';
import '../widgets/main_navigation.dart';
import 'constants.dart';

/// Configuration du routeur de l'application
final appRouter = GoRouter(
  initialLocation: AppConstants.homeRoute,
  routes: [
    // Navigation principale avec BottomNavigationBar
    GoRoute(
      path: AppConstants.homeRoute,
      builder: (context, state) => const MainNavigation(),
    ),

    // Détail d'une œuvre (seule route indépendante)
    GoRoute(
      path: '${AppConstants.artworkDetailRoute}/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ArtworkDetailScreen(artworkId: id);
      },
    ),
  ],
);
