import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manga_finder/src/config/app_route.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';

class MangaCard extends StatelessWidget {
  const MangaCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.id,
  });

  final String imageUrl;
  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoute.details, extra: id);
      },
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        errorWidget: (context, url, error) {
          return const Center(child: Text('No Image Found'));
        },
        imageBuilder: (context, imageProvider) {
          return SizedBox(
            height: 25.h,
            width: 30.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AspectRatio(
                  aspectRatio: 2.2 / 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppColors.electricRuby,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                ),
                Expanded(child: Text(title)),
              ],
            ),
          );
        },
      ),
    );
  }
}
