import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.shape = const StadiumBorder(),
    required this.backgroundColor,
    this.foregroundColor,
    required this.width,
    required this.height,
    required this.label,
  });
  final VoidCallback? onPressed;
  final OutlinedBorder shape;
  final Color backgroundColor;
  final Color? foregroundColor;
  final double width, height;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: shape,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            elevation: 10,
            minimumSize: Size(width, height)),
        child: Text(label));
  }
}
