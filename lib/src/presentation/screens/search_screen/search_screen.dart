import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manga_finder/src/blocs/search_mangas/search_mangas_bloc.dart';
import 'package:manga_finder/src/constants/app_colors.dart';
import 'package:manga_finder/src/presentation/screens/screen_layout/screen_layout.dart';
import 'package:manga_finder/src/presentation/screens/search_screen/widgets/search_card.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: SearchBar(
                controller: _controller,
                leading: IconButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        context
                            .read<SearchMangaBloc>()
                            .add(SearchForMangaEvent(query: _controller.text));
                      } else {
                        context
                            .read<SearchMangaBloc>()
                            .add(const RemoveSearchedEvent());
                      }
                    },
                    icon: const FaIcon(FontAwesomeIcons.magnifyingGlass)),
              ),
            ),
            IconButton(
                onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.sliders)),
          ],
        ),
        SizedBox(height: 2.h),
        BlocBuilder<SearchMangaBloc, SearchMangaState>(
            builder: (context, state) {
          switch (state.runtimeType) {
            case SearchLoadingState:
              return SizedBox(
                height: 80.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.electricRuby,
                  ),
                ),
              );
            case SearchSuccessState:
              final successState = state as SearchSuccessState;
              if (successState.mangas.isEmpty) {
                return SizedBox(
                  height: 70.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No Manga Found'),
                      SizedBox(height: 2.h),
                      Image.asset(''),
                    ],
                  ),
                );
              }
              return SizedBox(
                height: 70.h,
                child: ListView.builder(
                    itemCount: successState.mangas.length,
                    itemBuilder: (context, index) {
                      return SearchCard(
                          imageUrl: successState.mangas[index].imageUrl,
                          title: successState.mangas[index].title,
                          synopsis:
                              successState.mangas[index].synopsis.toString(),
                          status: successState.mangas[index].status.toString(),
                          malId: successState.mangas[index].malId);
                    }),
              );
            default:
              return const SizedBox.shrink();
          }
        }),
      ],
    ));
  }
}
