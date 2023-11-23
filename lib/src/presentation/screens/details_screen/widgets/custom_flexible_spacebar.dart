import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/models/manga_details_model.dart';
import '../../../widgets/custom_text.dart';
import 'custom_status_label.dart';
import 'genres_listview.dart';

class CustomFlexibleSpaceBar extends StatelessWidget {
  const CustomFlexibleSpaceBar({super.key, required this.manga});

  final MangaDetailsModel manga;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
        centerTitle: true,
        expandedTitleScale: 1,
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: manga.imageUrl,
              fit: BoxFit.fill,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.05),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  title: manga.title,
                  maxLines: 4,
                  horizontalPadding: 20,
                ),
                GenresListView(genres: manga.genres),
                SizedBox(height: 2.h),
                Builder(builder: (context) {
                  switch (manga.status) {
                    case ('Finished'):
                      return const CustomStatusLabel(
                          color: Colors.green,
                          icon: FontAwesomeIcons.checkDouble,
                          label: 'Finished');
                    case ('Publishing'):
                      return const CustomStatusLabel(
                          color: Colors.amber,
                          icon: FontAwesomeIcons.clock,
                          label: 'Ongoing');
                    case ('Hiatus'):
                      return CustomStatusLabel(
                          color: Colors
                              .red.shade800, //TODO: change icon appropriately
                          icon: FontAwesomeIcons.clock,
                          label: 'Hiatus');
                    case ('Discontinued'):
                      return const CustomStatusLabel(
                          color: Colors.black,
                          icon: FontAwesomeIcons.stop,
                          label: 'Discontinued');
                    case ('Upcoming'):
                      return const CustomStatusLabel(
                          color: Colors.amber,
                          icon: FontAwesomeIcons.clock,
                          label: 'Upcoming');
                  }
                  return const SizedBox.shrink();
                }),
                SizedBox(height: 2.h),
              ],
            )
          ],
        ));
  }
}
