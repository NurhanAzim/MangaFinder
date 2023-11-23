import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manga_finder/src/blocs/Auth/authentication_bloc.dart';
import 'package:manga_finder/src/config/app_route.dart';
import 'package:manga_finder/src/constants/assets_constants.dart';
import 'package:manga_finder/src/presentation/screens/login_screen/widgets/social_card.dart';
import 'package:manga_finder/src/presentation/screens/screen_layout/screen_layout.dart';
import 'package:manga_finder/src/presentation/widgets/custom_button.dart';
import 'package:manga_finder/src/presentation/widgets/custom_textformfield.dart';
import 'package:manga_finder/src/utils/extensions/extensions.dart';
import 'package:manga_finder/src/utils/helpers/validator.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  bool isSignInLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          GoRouter.of(context).go(AppRoute.homescreen);
        } else if (state is UnAuthenticatedState) {
          GoRouter.of(context).go(AppRoute.loginscreen);
        } else if (state is AuthErrorState) {
          context.showerrorsnackbar(title: 'Something went wrong');
        }
      },
      child: ScreenLayout(
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: 100.h,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AssetsConstants.appicon,
                        height: 15.h,
                      ),
                      SizedBox(height: 4.h),
                      const Text(
                        'Welcome back, buddy',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 7.h),
                      CustomTextFormField(
                          validator: (value) {
                            return !Validators.isValidEmail(value!)
                                ? 'Enter a valid email'
                                : null;
                          },
                          hintText: "Enter your email",
                          keyboardType: TextInputType.emailAddress,
                          isSuffix: false,
                          icon: Icons.email,
                          controller: _emailController),
                      SizedBox(height: 2.h),
                      CustomTextFormField(
                          hintText: 'Enter your password',
                          keyboardType: TextInputType.text,
                          isSuffix: false,
                          icon: Icons.lock,
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            return value!.length < 6
                                ? 'Enter a valid password'
                                : null;
                          }),
                      SizedBox(
                        height: 4.h,
                      ),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return const CircularProgressIndicator();
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                label: 'Continue',
                                height: 7.h,
                                width: 35.w,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(EmailSignInAuthEvent(
                                            _emailController.text,
                                            _passwordController.text));
                                  }
                                },
                              ),
                              SizedBox(width: 2.w),
                              CustomButton(
                                width: 35.w,
                                height: 7.h,
                                label: 'Sign up',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(EmailSignUpAuthEvent(
                                            _emailController.text,
                                            _passwordController.text));
                                  }
                                },
                              ),
                            ],
                          );
                        }
                      })
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
                const Text(
                  'OR',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.h),
                isSignInLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SocialSignInButton(
                        provider: 'Google',
                        img:
                            'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png',
                        func: () async {
                          setState(() {
                            isSignInLoading = true;
                          });
                          try {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(const GoogleAuthEvent());
                          } catch (e) {
                            setState(() {
                              context.showerrorsnackbar(
                                  title: 'Sign In Failed');
                              isSignInLoading = false;
                            });
                          }
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
