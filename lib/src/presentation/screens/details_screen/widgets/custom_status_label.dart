import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../widgets/custom_text.dart';

class CustomStatusLabel extends StatelessWidget {
  const CustomStatusLabel({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            color: color),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: AppColors.platinumGray,
            ),
            const SizedBox(width: 3),
            CustomText(
              title: label,
              size: 10,
              color: AppColors.platinumGray,
            )
          ],
        ));
  }
}
