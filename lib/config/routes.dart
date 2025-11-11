import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import '../screens/detail_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/signin_screen.dart';
import '../screens/signup_screen.dart';

// Bottom navigation shell wrapper
import '../widgets/bottom_navigation_shell.dart';

// ------------------ Route name constants ------------------
class AppRoutes {
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const home = '/home';
  static const favorites = '/favorites';
  static const profile = '/profile';
  static const details = '/details'; // usage: /details/:id
}

// Navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeBranchKey = GlobalKey<NavigatorState>();
final _favBranchKey = GlobalKey<NavigatorState>();
final _profileBranchKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: [
      // Auth (outside shell)
      GoRoute(
        path: AppRoutes.signIn,
        name: 'sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      // Detail (modal over shell)
      GoRoute(
        path: '${AppRoutes.details}/:id',
        name: 'detail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final animeId = state.pathParameters['id'] ?? '';
          return DetailScreen(animeId: animeId);
        },
      ),
      // Shell with bottom nav (IndexedStack keeps state per tab)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) => BottomNavigationShell(child: navShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeBranchKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _favBranchKey,
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                name: 'favorite',
                builder: (context, state) => const FavoriteScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileBranchKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('404 - Page Not Found', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('Path: ${state.uri.path}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
