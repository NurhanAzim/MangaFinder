import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manga_finder/src/blocs/manga_character/manga_character_bloc.dart';
import 'package:manga_finder/src/blocs/manga_details/manga_details_bloc.dart';
import 'package:manga_finder/src/blocs/manga_images/manga_images_bloc.dart';
import 'package:manga_finder/src/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/library_manga_model.dart';
import '../../../utils/services/database_service.dart';
import 'widgets/custom_flexible_spacebar.dart';
import 'widgets/sliverlist_item.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.id});
  final int id;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    context.read<MangaDetailsBloc>().add(LoadMangaDetails(widget.id));
    context.read<MangaImagesBloc>().add(LoadMangaImages(widget.id));
    context.read<MangaCharacterBloc>().add(LoadMangaCharacter(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaDetailsBloc, MangaDetailState>(
        builder: (context, state) {
      switch (state.runtimeType) {
        case MangaDetailsLoadingState:
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.electricRuby,
            ),
          );
        case MangaDetailsSuccessState:
          final succesState = state as MangaDetailsSuccessState;
          return Scaffold(
              backgroundColor: AppColors.darkForestGreen,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: false,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.electricRuby,
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.electricRuby),
                        child: IconButton(
                            onPressed: () {
                              String userId =
                                  Supabase.instance.client.auth.currentUser!.id;
                              LibraryManga manga = LibraryManga(
                                malId: succesState.manga.malId,
                                imageUrl: succesState.manga.imageUrl,
                                title: succesState.manga.title,
                                synopsis: succesState.manga.synopsis,
                                userId: userId,
                              );

                              DatabaseService()
                                  .addManga(manga: manga)
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Manga Added to Library!'),
                                  ),
                                );
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Failed to Add Manga: $error'),
                                  ),
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: AppColors.platinumGray,
                            )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                    flexibleSpace:
                        CustomFlexibleSpaceBar(manga: succesState.manga),
                    expandedHeight: 65.h,
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      child: SliverListItem(manga: succesState.manga),
                    )
                  ])),
                ],
              ));
        case MangaDetailsErrorState:
          return const Text('error');
        default:
          return const SizedBox.shrink();
      }
    });
  }
}
