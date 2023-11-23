import 'package:flutter/material.dart';
import 'package:manga_finder/src/constants/app_colors.dart';
import 'package:manga_finder/src/presentation/widgets/custom_dialog_box.dart';

const Duration duration = Duration(milliseconds: 500);

extension ShowSnackBar on BuildContext {
  showsnackbar({required title, Color color = AppColors.darkForestGreen}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content:
          Text(title, style: const TextStyle(color: AppColors.platinumGray)),
      backgroundColor: color,
      duration: duration,
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
      duration: duration,
    ));
  }
}

extension ShowDialog on BuildContext {
  void showDialogBox({
    required String title,
    required String description,
    required VoidCallback action,
  }) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          description: description,
          action: action,
        );
      },
    );
  }
}
