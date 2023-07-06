import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manga_finder/src/config/app_route.dart';
import 'package:manga_finder/src/constants/app_colors.dart';
import 'package:manga_finder/src/presentation/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_text.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.malId,
  });

  final int malId;
  final String imageUrl, title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Stack(
        children: [
          Center(
            child: CachedNetworkImage(
              height: 100.h,
              imageUrl: imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            width: 100.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.2),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.04, 0.6])),
          ),
          Positioned(
              bottom: 2.h,
              left: 4.w,
              child: SizedBox(
                width: 80.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: title,
                      size: 16,
                      maxLines: 2,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Center(
                      child: CustomButton(
                        backgroundColor: AppColors.electricRuby,
                        foregroundColor: Colors.white,
                        width: 15,
                        height: 15,
                        label: 'Details',
                        onPressed: () {
                          context.push(AppRoute.details, extra: malId);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
