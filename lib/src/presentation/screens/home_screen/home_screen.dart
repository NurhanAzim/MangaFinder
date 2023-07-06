import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:manga_finder/src/blocs/bloc_constants.dart';
import 'package:manga_finder/src/blocs/popular_mangas/popular_mangas_event.dart';
import 'package:manga_finder/src/blocs/trending_mangas/trending_mangas_bloc.dart';
import 'package:manga_finder/src/constants/app_colors.dart';
import 'package:manga_finder/src/presentation/screens/home_screen/widgets/carousel_widget.dart';
import 'package:manga_finder/src/presentation/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import '../../../blocs/popular_mangas/popular_mangas_bloc.dart';
import '../../../blocs/popular_mangas/popular_mangas_state.dart';
import '../../../blocs/random_mangas/random_manga_bloc.dart';
import 'widgets/manga_listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _popularMangaController = ScrollController();
  final ScrollController _trendingMangaController = ScrollController();
  final InternetConnectionChecker _checker = InternetConnectionChecker();
  bool isOnline = false;
  late StreamSubscription<InternetConnectionStatus> listener;

  void _onPopularMangaScroll() async {
    if (_popularMangaController.position.atEdge) {
      if (_popularMangaController.position.pixels != 0 && isOnline) {
        context.read<PopularMangaBloc>().add(LoadPopularMangaEvent());
      }
    }
  }

  void _onTrendingMangaScroll() async {
    if (_trendingMangaController.position.atEdge) {
      if (_trendingMangaController.position.pixels != 0 && isOnline) {
        context.read<TrendingMangaBloc>().add(LoadTrendingMangaEvent());
      }
    }
  }

  @override
  void initState() {
    _popularMangaController.addListener(_onPopularMangaScroll);
    _trendingMangaController.addListener(_onTrendingMangaScroll);
    listener = _checker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isOnline = true;
          break;
        case InternetConnectionStatus.disconnected:
          isOnline = false;
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _popularMangaController
      ..removeListener(_onPopularMangaScroll)
      ..dispose();
    _trendingMangaController
      ..removeListener(_onTrendingMangaScroll)
      ..dispose();
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkForestGreen,
      body: RefreshIndicator(
        onRefresh: () {
          context.read<RandomMangaBloc>().add(LoadRandomMangaEvent());
          context.read<PopularMangaBloc>().add(LoadPopularMangaEvent());
          context.read<TrendingMangaBloc>().add(LoadTrendingMangaEvent());
          return Future.delayed(const Duration(seconds: 2));
        },
        child: BlocBuilder<RandomMangaBloc, RandomMangaState>(
          builder: (context, state) {
            switch (state.status) {
              case StateStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.electricRuby,
                  ),
                );
              case StateStatus.success:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselWidget(
                        list: state.randomMangas,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            const CustomText(
                              title: 'Popular Manga',
                              headline: false,
                              color: AppColors.platinumGray,
                              size: 16,
                            ),
                            SizedBox(height: 2.h),
                            BlocBuilder<PopularMangaBloc, PopularMangaState>(
                              builder: (context, state) {
                                if (state.status == StateStatus.initial) {
                                  return SizedBox(
                                    height: 25.h,
                                  );
                                } else if (state.status ==
                                    StateStatus.success) {
                                  return MangaListView(
                                      controller: _popularMangaController,
                                      mangas: state.popularMangas,
                                      hasReachedMax: state.hasReachedMax);
                                } else {
                                  return const Text('error');
                                }
                              },
                            ),
                            SizedBox(height: 2.h),
                            const CustomText(
                              title: 'Trending Manga',
                              headline: false,
                              color: AppColors.platinumGray,
                              size: 16,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            BlocBuilder<TrendingMangaBloc, TrendingMangaState>(
                                builder: (context, state) {
                              switch (state.status) {
                                case StateStatus.initial:
                                  return SizedBox(height: 25.h);
                                case StateStatus.success:
                                  return MangaListView(
                                      controller: _trendingMangaController,
                                      mangas: state.trendingMangas,
                                      hasReachedMax: state.hasReachedMax);
                                case StateStatus.failure:
                                  return const Text('error');
                                default:
                                  return Container();
                              }
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              case StateStatus.failure:
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Something went wrong\n  Please refresh page')
                          ])),
                );
            }
          },
        ),
      ),
    );
  }
}
