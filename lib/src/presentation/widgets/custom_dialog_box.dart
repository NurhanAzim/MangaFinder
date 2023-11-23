import 'package:flutter/material.dart';
import 'package:manga_finder/src/constants/app_colors.dart';

class CustomDialogBox extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback action;
  const CustomDialogBox(
      {super.key,
      required this.title,
      required this.description,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style:
                const TextStyle(color: AppColors.darkForestGreen, fontSize: 22),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            description,
            style:
                const TextStyle(color: AppColors.darkForestGreen, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18),
                  )),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () {
                  action();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
