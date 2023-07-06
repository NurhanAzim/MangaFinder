import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:manga_finder/src/constants/app_colors.dart';
import 'package:manga_finder/src/presentation/screens/home_screen/home_screen.dart';
import 'package:manga_finder/src/presentation/screens/library_screen/library_screen.dart';
import 'package:manga_finder/src/presentation/screens/search_screen/search_screen.dart';
import 'package:manga_finder/src/utils/extensions/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/Auth/authentication_bloc.dart';
import '../../../config/app_route.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    LibraryScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          GoRouter.of(context).go(AppRoute.homescreen);
        } else if (state is UnAuthenticatedState) {
          GoRouter.of(context).go(AppRoute.loginscreen);
        } else if (state is AuthErrorState) {
          context.showsnackbar(title: 'Something went wrong');
        }
      },
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20.0,
              sigmaY: 20.0,
            ),
            child: Opacity(
              opacity: 0.95,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                backgroundColor: AppColors.darkForestGreen,
                selectedItemColor: AppColors.electricRuby,
                unselectedItemColor: AppColors.platinumGray,
                currentIndex: _selectedIndex,
                onTap: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.house,
                      size: 18.sp,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 18.sp,
                      ),
                      label: 'Search'),
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.bookBookmark,
                      size: 18.sp,
                    ),
                    label: 'Library',
                  )
                ],
              ),
            ),
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
    );
  }
}
