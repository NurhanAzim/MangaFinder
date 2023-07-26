import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:manga_finder/src/blocs/Auth/authentication_bloc.dart';
import 'package:manga_finder/src/blocs/library_mangas/library_manga_bloc.dart';
import 'package:manga_finder/src/blocs/library_mangas/library_manga_event.dart';
import 'package:manga_finder/src/blocs/manga_character/manga_character_bloc.dart';
import 'package:manga_finder/src/blocs/manga_details/manga_details_bloc.dart';
import 'package:manga_finder/src/blocs/manga_images/manga_images_bloc.dart';
import 'package:manga_finder/src/blocs/popular_mangas/popular_mangas_bloc.dart';
import 'package:manga_finder/src/blocs/popular_mangas/popular_mangas_event.dart';
import 'package:manga_finder/src/blocs/random_mangas/random_manga_bloc.dart';
import 'package:manga_finder/src/blocs/search_mangas/search_mangas_bloc.dart';
import 'package:manga_finder/src/blocs/trending_mangas/trending_mangas_bloc.dart';
import 'package:manga_finder/src/config/app_theme.dart';
import 'package:manga_finder/src/di/get_it.dart' as get_it;
import 'package:manga_finder/src/config/app_route.dart';
import 'package:manga_finder/src/utils/bloc_observer.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  String baseUrl = dotenv.env['SUPABASE_BASE_URL'] ?? '';
  String anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  get_it.init();

  Bloc.observer = MyBlocObserver();

  await Supabase.initialize(
    url: baseUrl,
    anonKey: anonKey,
    debug: false,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(),
        ),
        BlocProvider<PopularMangaBloc>(
          create: (_) => get_it.gI()..add(LoadMorePopularMangaEvent()),
        ),
        BlocProvider<TrendingMangaBloc>(
          create: (_) => get_it.gI()..add(LoadTrendingMangaEvent()),
        ),
        BlocProvider<RandomMangaBloc>(
            create: (_) => get_it.gI()..add(LoadRandomMangaEvent())),
        BlocProvider<SearchMangaBloc>(
          create: (_) => get_it.gI<SearchMangaBloc>(),
        ),
        BlocProvider<MangaDetailsBloc>(
          create: (_) => get_it.gI<MangaDetailsBloc>(),
        ),
        BlocProvider<MangaImagesBloc>(
          create: (_) => get_it.gI<MangaImagesBloc>(),
        ),
        BlocProvider<MangaCharacterBloc>(
          create: (_) => get_it.gI<MangaCharacterBloc>(),
        ),
        BlocProvider<LibraryMangaBloc>(
            create: (_) =>
                get_it.gI<LibraryMangaBloc>()..add(LibraryMangaInitialEvent())),
      ],
      child: const MangaFinder(),
    ),
  );
}

class MangaFinder extends StatefulWidget {
  const MangaFinder({super.key});

  @override
  State<MangaFinder> createState() => _MangaFinderState();
}

class _MangaFinderState extends State<MangaFinder> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) => MaterialApp.router(
              title: 'Manga Finder',
              debugShowCheckedModeBanner: false,
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
              routeInformationProvider:
                  AppRoute.router.routeInformationProvider,
              routeInformationParser: AppRoute.router.routeInformationParser,
              routerDelegate: AppRoute.router.routerDelegate,
              scrollBehavior:
                  const MaterialScrollBehavior().copyWith(dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown
              }),
            ));
  }
}
