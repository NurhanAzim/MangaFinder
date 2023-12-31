import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/app_route.dart';
import '../../../../constants/app_colors.dart';
import '../../../../utils/services/database_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class LibraryCard extends StatelessWidget {
  const LibraryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
    required this.malId,
  });

  final String title;
  final String imageUrl;
  final String synopsis;
  final int malId;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 3.w,
      ),
      child: AspectRatio(
        aspectRatio: 2.8 / 1.6,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 30.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                return const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.electricRuby),
                );
              },
              errorWidget: (context, url, error) {
                return const Center(
                  child: Icon(Icons.error),
                );
              },
            ),
            SizedBox(
              width: 3.w,
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  size: 10,
                  color: AppColors.platinumGray,
                  textAlign: TextAlign.start,
                ),
                RichText(
                  maxLines: 6,
                  text: TextSpan(
                      text: 'Synopsis: ',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.electricRuby,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w900),
                      children: [
                        TextSpan(
                            text: synopsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: AppColors.platinumGray,
                                    fontSize: 8.sp))
                      ]),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomButton(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.green,
                      foregroundColor: AppColors.platinumGray,
                      width: 4,
                      height: 15,
                      label: '+ Details',
                      onPressed: () {
                        context.push(AppRoute.details, extra: malId);
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          DatabaseService().deleteManga(malId).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Manga Removed'),
                              ),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to Remove Manga: $error'),
                              ),
                            );
                          });
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
