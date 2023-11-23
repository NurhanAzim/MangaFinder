import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  final String provider;
  final String img;
  final void Function() func;
  const SocialSignInButton(
      {super.key,
      required this.img,
      required this.func,
      required this.provider});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: func,
        icon: SizedBox(
          height: 20,
          width: 20,
          child: Image.network(img),
        ),
        label: Text('Continue with $provider'));
  }
}
