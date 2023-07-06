import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/app_route.dart';
import '../../../../constants/app_colors.dart';

import '../../../../data/models/library_manga_model.dart';
import '../../../../utils/services/database_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class SearchCard extends StatelessWidget {
  const SearchCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.synopsis,
      required this.status,
      required this.malId});

  final String imageUrl, title, synopsis, status;
  final int malId;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
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
                        image: imageProvider, fit: BoxFit.cover),
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: title,
                      color: AppColors.platinumGray,
                      textAlign: TextAlign.left,
                      size: 10,
                    ),
                    RichText(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: 'Status: ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.amber,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(
                                  text: status,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontSize: 8.sp,
                                        color: AppColors.platinumGray,
                                      ))
                            ])),
                    SizedBox(
                      height: 12.h,
                      child: RichText(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: 'Synopsis:  ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
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
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomButton(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.green,
                            foregroundColor: AppColors.platinumGray,
                            width: 15,
                            height: 15,
                            label: 'Details',
                            onPressed: () {
                              context.push(AppRoute.details, extra: malId);
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                String userId = Supabase
                                    .instance.client.auth.currentUser!.id;
                                LibraryManga manga = LibraryManga(
                                  malId: malId,
                                  imageUrl: imageUrl,
                                  title: title,
                                  synopsis: synopsis,
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
                              icon: const Icon(Icons.favorite)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
