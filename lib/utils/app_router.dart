import 'package:go_router/go_router.dart';
import '../screens/ar_screen.dart';
import '../screens/artworks/artwork_detail_screen.dart';
import '../screens/vr_screen.dart';
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

    // Détail d'une œuvre
    GoRoute(
      path: '${AppConstants.artworkDetailRoute}/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ArtworkDetailScreen(artworkId: id);
      },
    ),

    // Réalité Augmentée
    GoRoute(
      path: AppConstants.arRoute,
      builder: (context, state) => const ARScreen(),
    ),

    // Réalité Virtuelle
    GoRoute(
      path: AppConstants.vrRoute,
      builder: (context, state) => const VRScreen(),
    ),
  ],
);
