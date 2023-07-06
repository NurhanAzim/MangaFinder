import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../../data/models/manga_model.dart';
import 'manga_card.dart';

class MangaListView extends StatelessWidget {
  const MangaListView({
    super.key,
    required this.controller,
    required this.mangas,
    required this.hasReachedMax,
  });

  final ScrollController controller;
  final List<MangaModel> mangas;
  final bool hasReachedMax;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      width: 100.w,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: hasReachedMax ? mangas.length : mangas.length + 1, //max is 5
        itemBuilder: (context, index) {
          if (index < mangas.length) {
            return MangaCard(
              id: mangas[index].malId,
              imageUrl: mangas[index].imageUrl,
              title: mangas[index].title,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.electricRuby,
              ),
            );
          }
        },
      ),
    );
  }
}
