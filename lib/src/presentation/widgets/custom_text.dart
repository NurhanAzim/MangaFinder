import 'package:flutter/material.dart';
import 'package:manga_finder/src/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  final bool headline;
  final String title;
  final double size;
  final double horizontalPadding;
  final TextAlign textAlign;
  final int maxLines;
  final Color? color;

  const CustomText(
      {super.key,
      required this.title,
      this.size = 15,
      this.headline = true,
      this.horizontalPadding = 0,
      this.maxLines = 1,
      this.color = AppColors.platinumGray,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        title,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: (headline) ? TextOverflow.visible : TextOverflow.ellipsis,
        style: (headline)
            ? Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: size.sp,
                fontWeight: FontWeight.bold,
                color: color ?? Theme.of(context).textTheme.displayLarge!.color,
                height: 1.5)
            : Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: size.sp,
                color: color ?? Theme.of(context).textTheme.titleMedium!.color),
      ),
    );
  }
}
