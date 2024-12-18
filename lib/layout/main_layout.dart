import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/screen/coming_soon.dart';
import 'package:kualiva/home/home_screen.dart';
import 'package:kualiva/profile/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<MainLayout> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Container(
          //     width: double.maxFinite,
          //     decoration: BoxDecoration(
          //       color: theme(context).scaffoldBackgroundColor,
          //       image: DecorationImage(
          //         image: AssetImage(ImageConstant.background1),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          Scaffold(
            // backgroundColor: Colors.transparent,
            body: _body(context),
            bottomNavigationBar: _bottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    switch (_selectedPage) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ComingSoon();
      case 2:
        return const ComingSoon();
      case 3:
        return const ComingSoon();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  Widget _bottomNavBar() {
    return CurvedNavigationBar(
      index: _selectedPage,
      backgroundColor: Colors.transparent,
      color: theme(context).colorScheme.onSecondaryContainer,
      buttonBackgroundColor: appTheme.amber700,
      items: [
        // Icon(
        //   _selectedPage == 0 ? Icons.home : Icons.home_outlined,
        //   size: 30.h,
        // ),
        // Image.asset(
        //   _selectedPage == 1
        //       ? ImageConstant.navbarItem2Sel
        //       : theme(context).brightness == Brightness.dark
        //           ? ImageConstant.navbarItem2Dark
        //           : ImageConstant.navbarItem2,
        //   fit: BoxFit.cover,
        //   width: 30.h,
        //   height: 30.h,
        // ),
        // Image.asset(
        //   _selectedPage == 2
        //       ? ImageConstant.navbarItem3Sel
        //       : theme(context).brightness == Brightness.dark
        //           ? ImageConstant.navbarItem3Dark
        //           : ImageConstant.navbarItem3,
        //   fit: BoxFit.cover,
        //   width: 30.h,
        //   height: 30.h,
        // ),
        // Icon(
        //   _selectedPage == 3 ? Icons.mail : Icons.mail_outline,
        //   size: 30.h,
        // ),
        // Icon(
        //   _selectedPage == 4 ? Icons.person : Icons.person_outline,
        //   size: 30.h,
        // ),
        _bottomNavBarItems(
          context,
          index: 0,
          label: context.tr("home_nav_bar.nav_1"),
          selectedIcon: Icons.home,
          unselectedIcon: Icons.home_outlined,
        ),
        _bottomNavBarItems(
          context,
          index: 1,
          label: context.tr("home_nav_bar.nav_2"),
          selectedImage: ImageConstant.navbarItem2Sel,
          unselectedImage: ImageConstant.navbarItem2,
          imageDark: ImageConstant.navbarItem2Dark,
        ),
        _bottomNavBarItems(
          context,
          index: 2,
          label: context.tr("home_nav_bar.nav_3"),
          selectedImage: ImageConstant.navbarItem3Sel,
          unselectedImage: ImageConstant.navbarItem3,
          imageDark: ImageConstant.navbarItem3Dark,
        ),
        _bottomNavBarItems(
          context,
          index: 3,
          label: context.tr("home_nav_bar.nav_4"),
          selectedIcon: Icons.mail,
          unselectedIcon: Icons.mail_outline,
        ),
        _bottomNavBarItems(
          context,
          index: 4,
          label: context.tr("home_nav_bar.nav_5"),
          selectedIcon: Icons.person,
          unselectedIcon: Icons.person_outline,
        ),
      ],
      onTap: (value) {
        setState(() {
          _selectedPage = value;
        });
      },
    );
  }

  Widget _bottomNavBarItems(
    BuildContext context, {
    required int index,
    required String label,
    IconData? unselectedIcon,
    IconData? selectedIcon,
    String? unselectedImage,
    String? selectedImage,
    String? imageDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: unselectedIcon != null,
          child: Icon(
            _selectedPage == index ? selectedIcon : unselectedIcon,
            size: 30.h,
            color: _selectedPage == index
                ? appTheme.black900
                : theme(context).iconTheme.color,
          ),
        ),
        Visibility(
          visible: unselectedImage != null,
          child: Image.asset(
            _selectedPage == index
                ? selectedImage ?? "-"
                : theme(context).brightness == Brightness.dark
                    ? imageDark ?? "-"
                    : unselectedImage ?? "-",
            fit: BoxFit.cover,
            width: 30.h,
            height: 30.h,
          ),
        ),
        Visibility(
          visible: _selectedPage == index,
          child: Center(
            child: Text(
              label,
              style: theme(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
