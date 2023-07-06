import 'package:flutter/material.dart';
import 'package:manga_finder/src/constants/app_colors.dart';

extension ShowSnackBar on BuildContext {
  showsnackbar({required title, Color color = AppColors.darkForestGreen}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content:
          Text(title, style: const TextStyle(color: AppColors.platinumGray)),
      backgroundColor: color,
    ));
  }

  showerrorsnackbar(
      {required title,
      Color color = AppColors.platinumGray,
      String message = ''}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        title + ": " + message,
        style: const TextStyle(color: Colors.red),
      ),
      backgroundColor: color,
    ));
  }
}
