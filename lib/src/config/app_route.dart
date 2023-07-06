import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manga_finder/src/presentation/screens/base_screen/base_screen.dart';
import 'package:manga_finder/src/presentation/screens/details_screen/details_screen.dart';
import 'package:manga_finder/src/presentation/screens/library_screen/library_screen.dart';
import 'package:manga_finder/src/presentation/screens/login_screen/login_screen.dart';
import 'package:manga_finder/src/presentation/screens/screen_layout/screen_layout.dart';
import 'package:manga_finder/src/presentation/screens/search_screen/search_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRoute {
  static const root = '/';
  static const loginscreen = '/loginscreen';
  static const homescreen = '/homescreen';
  static const details = '/details';
  static const search = '/search';
  static const library = '/library';

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: root,
          builder: (context, state) {
            if (Supabase.instance.client.auth.currentUser != null) {
              return const BaseScreen();
            } else {
              return const LoginScreen(); //replace with splash
            }
          }),
      GoRoute(
        path: loginscreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: homescreen,
        builder: (context, state) => const BaseScreen(),
      ),
      GoRoute(
        path: details,
        builder: (context, state) {
          final id = state.extra as int;
          return DetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: library,
        builder: (context, state) => const LibraryScreen(),
      ),
    ],
    initialLocation: root,
    errorBuilder: (context, state) => const ScreenLayout(
        child: Center(
      child: Text('error'),
    )),
  );

  static GoRouter get router => _router;
}
