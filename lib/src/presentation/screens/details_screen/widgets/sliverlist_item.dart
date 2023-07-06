import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_finder/src/blocs/manga_character/manga_character_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/assets_constants.dart';
import '../../../../data/models/manga_details_model.dart';
import '../../../widgets/custom_text.dart';

class SliverListItem extends StatelessWidget {
  const SliverListItem({
    super.key,
    required this.manga,
  });
  final MangaDetailsModel manga;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: 15,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              text: 'Synopsis: ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.electricRuby,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w900),
              children: [
                TextSpan(
                    text: manga.synopsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.platinumGray, fontSize: 10.sp))
              ]),
        ),
        SizedBox(height: 2.h),
        CustomText(
            title: 'Main Characters',
            size: 12.sp,
            color: AppColors.electricRuby),
        BlocBuilder<MangaCharacterBloc, MangaCharacterState>(
            builder: (context, state) {
          switch (state.runtimeType) {
            case MangaCharacterLoadingState:
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.electricRuby,
                ),
              );
            case MangaCharacterSuccessState:
              final successState = state as MangaCharacterSuccessState;
              return SizedBox(
                height: 25.h,
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 1.h),
                    itemCount: successState.characters.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return AspectRatio(
                        aspectRatio: 2 / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: FadeInImage.memoryNetwork(
                                    placeholderErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        AssetsConstants.placeholder,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                        AssetsConstants.placeholder,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    placeholder: kTransparentImage,
                                    image:
                                        successState.characters[index].image),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            CustomText(
                              title: successState.characters[index].name,
                              size: 8,
                              color: AppColors.platinumGray,
                            ),
                          ],
                        ),
                      );
                    }),
              );
            default:
              return Container();
          }
        })
      ],
    );
  }
}
