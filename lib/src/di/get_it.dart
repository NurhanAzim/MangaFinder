import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:manga_finder/src/blocs/manga_character/manga_character_bloc.dart';
import 'package:manga_finder/src/blocs/manga_details/manga_details_bloc.dart';
import 'package:manga_finder/src/blocs/manga_images/manga_images_bloc.dart';
import 'package:manga_finder/src/blocs/popular_mangas/popular_mangas_bloc.dart';
import 'package:manga_finder/src/blocs/random_mangas/random_manga_bloc.dart';
import 'package:manga_finder/src/blocs/search_mangas/search_mangas_bloc.dart';
import 'package:manga_finder/src/blocs/trending_mangas/trending_mangas_bloc.dart';
import 'package:manga_finder/src/data/core/dio_client.dart';
import 'package:manga_finder/src/data/data_sources/local_data_source.dart';
import 'package:manga_finder/src/data/data_sources/remote_data_source.dart';
import 'package:manga_finder/src/data/repositories/manga_repo_impl.dart';

final gI = GetIt.I;

Future init() async {
  // Initialize DioClient
  gI.registerLazySingleton<DioClient>(() => DioClient());

  // RemoteDataSource depends on DioClient
  gI.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(gI()));

  gI.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  final networkInfo = InternetConnectionChecker();

  gI.registerLazySingleton<MangaRepository>(
      () => MangaRepoImpl(gI(), gI(), networkInfo));

  gI.registerFactory(() => PopularMangaBloc(gI()));
  gI.registerFactory(() => TrendingMangaBloc(gI()));
  gI.registerFactory(() => RandomMangaBloc(gI()));
  gI.registerFactory(() => SearchMangaBloc(gI()));
  gI.registerFactory(() => MangaDetailsBloc(gI()));
  gI.registerFactory(() => MangaImagesBloc(gI()));
  gI.registerFactory(() => MangaCharacterBloc(gI()));
}
