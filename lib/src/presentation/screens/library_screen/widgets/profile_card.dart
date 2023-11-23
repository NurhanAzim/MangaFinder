import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_finder/src/blocs/Auth/authentication_bloc.dart';
import 'package:manga_finder/src/presentation/widgets/custom_button.dart';
import 'package:manga_finder/src/presentation/widgets/custom_text.dart';
import 'package:manga_finder/src/utils/extensions/extensions.dart';
import 'package:sizer/sizer.dart';

class ProfileCard extends StatelessWidget {
  final String email;
  const ProfileCard({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: 'Hello ${email.split('@')[0]}',
                size: 12,
              ),
              CustomButton(
                width: 64,
                height: 36,
                label: 'Logout',
                onPressed: () {
                  context.showDialogBox(
                      title: 'Logout',
                      description: 'Are you sure to logout',
                      action: () => BlocProvider.of<AuthenticationBloc>(context)
                          .add(const SignOutEvent()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
