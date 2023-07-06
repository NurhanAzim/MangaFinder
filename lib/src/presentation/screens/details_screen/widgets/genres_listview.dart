import 'package:flutter/material.dart';

import '../../../../data/models/manga_details_model.dart';
import '../../../widgets/custom_text.dart';

class GenresListView extends StatelessWidget {
  const GenresListView({
    super.key,
    required this.manga,
  });

  final MangaDetailsModel manga;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: (manga.genres.length / 4).ceil(),
      itemBuilder: (context, rowIndex) {
        final startIdx = rowIndex * 4;
        final endIdx = (startIdx + 4).clamp(0, manga.genres.length);
        final rowGenres = manga.genres.sublist(startIdx, endIdx);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < rowGenres.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CustomText(
                  title: rowGenres[i].name +
                      (i + 1 < rowGenres.length ? '  |  ' : ''),
                  size: 10,
                ),
              ),
          ],
        );
      },
    );
  }
}
