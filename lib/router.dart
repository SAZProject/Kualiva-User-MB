import 'package:flutter/material.dart';
import 'package:kualiva/auth/device_permission_screen.dart';
import 'package:kualiva/auth/otp_page_screen.dart';
import 'package:kualiva/auth/sign_in_screen.dart';
import 'package:kualiva/auth/sign_up_screen.dart';
import 'package:kualiva/common/screen/location_screen.dart';
import 'package:kualiva/data/model/f_n_b_model.dart';
import 'package:kualiva/data/model/review_model.dart';
import 'package:kualiva/data/model/ui_model/filters_model.dart';
import 'package:kualiva/data/model/ui_model/home_event_model.dart';
import 'package:kualiva/onboarding/onboarding_verifying_user.dart';
import 'package:kualiva/home/home_event_detail_screen.dart';
import 'package:kualiva/home/home_event_screen.dart';
import 'package:kualiva/places/add_places_screen.dart';
import 'package:kualiva/places/fnb/fnb_detail_screen.dart';
import 'package:kualiva/places/fnb/fnb_screen.dart';
import 'package:kualiva/places/fnb/fnb_cuisine_screen.dart';
import 'package:kualiva/places/fnb/fnb_detail_menu_screen.dart';
import 'package:kualiva/layout/main_layout.dart';
import 'package:kualiva/places/fnb/fnb_filters_screen.dart';
import 'package:kualiva/profile/account_setting_screen.dart';
import 'package:kualiva/profile/language_screen.dart';
import 'package:kualiva/profile/my_profile_screen.dart';
import 'package:kualiva/profile/profile_screen.dart';
import 'package:kualiva/report/report_place_screen.dart';
import 'package:kualiva/report/report_review_screen.dart';
import 'package:kualiva/review/review_form_screen.dart';
import 'package:kualiva/review/review_screen.dart';
import 'package:kualiva/onboarding/onboarding_screen.dart';
import 'package:kualiva/splash/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  static const String splashScreen = "/splash_screen";

  static const String onBoardingScreen = "/onboarding";

  static const String onBoardingVerifyUserScreen = "/onboarding_verify_user";

  static const String signInScreen = "/sign_in_screen";

  static const String signUpScreen = "/sign_up_screen";

  static const String otpScreen = "/otp_screen";

  static const String doneScreen = "/done_screen";

  static const String devicePermissionScreen = "/device_permission_screen";

  static const String homeNavigationScreen = "/home_nav_screen";

  static const String homeEventScreen = "/home_event_screen";

  static const String homeEventDetailScreen = "/home_event_detail_screen";

  static const String fnbScreen = "/f_n_b_screen";

  static const String fnbCuisineScreen = "/f_n_b_cuisine_screen";

  static const String fnbFilterScreen = "/f_n_b_filter_screen";

  static const String fnbDetailScreen = "/f_n_b_detail_screen";

  static const String fnbDetailMenuScreen = "/f_n_b_detail_menu_screen";

  static const String reviewScreen = "/review_screen";

  static const String reviewFormScreen = "/review_form_screen";

  static const String reportPlaceScreen = "/report_place_screen";

  static const String reportReviewScreen = "/report_review_screen";

  static const String profileScreen = "/profile_screen";

  static const String myProfileScreen = "my_profile_screen";

  static const String languageScreen = "language_screen";

  static const String accSettingScreen = "acc_setting_screen";

  static const String addPlaceScreen = "/add_place_screen";

  static const String locationScreen = "/location_screen";
}

Route<dynamic> generateRoute(RouteSettings routeSetting) {
  switch (routeSetting.name) {
    case AppRoutes.splashScreen:
      return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.onBoardingScreen:
      return PageTransition(
          child: const OnBoardingScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.onBoardingVerifyUserScreen:
      return PageTransition(
          child: const OnboardingVerifyingUser(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.signInScreen:
      return PageTransition(
          child: const SignInScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.signUpScreen:
      return PageTransition(
          child: const SignUpScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.otpScreen:
      return PageTransition(
          child: const OtpPageScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.devicePermissionScreen:
      return PageTransition(
          child: const DevicePermissionScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.homeNavigationScreen:
      return PageTransition(
          child: const MainLayout(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.homeEventScreen:
      return PageTransition(
          child: const WhatGoingOnScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.homeEventDetailScreen:
      final homeEventModel = routeSetting.arguments as HomeEventModel;
      return PageTransition(
          child: HomeEventDetailScreen(eventModel: homeEventModel),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.fnbScreen:
      return PageTransition(
          child: const FnbScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.fnbCuisineScreen:
      final cuisineTitle = routeSetting.arguments as String;
      return PageTransition(
          child: FnbCuisineScreen(cuisineTitle: cuisineTitle),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.fnbFilterScreen:
      final filterModel = routeSetting.arguments as FiltersModel?;
      return PageTransition(
          child: FnbFiltersScreen(getFilterModel: filterModel),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.fnbDetailScreen:
      final placeId = routeSetting.arguments as String;
      return PageTransition(
          child: FnbDetailScreen(placeId: placeId),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.fnbDetailMenuScreen:
      final listImageMenu = routeSetting.arguments as List<String>;
      return PageTransition(
          child: FnbDetailMenuScreen(listImageMenu: listImageMenu),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.reviewScreen:
      final placeId = routeSetting.arguments as String;
      return PageTransition(
          child: ReviewScreen(placeId: placeId),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.reviewFormScreen:
      // final fnbModel = routeSetting.arguments as FNBModel;
      final transaction = routeSetting.arguments as String;
      return PageTransition(
          child: ReviewFormScreen(transaction: transaction),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.reportPlaceScreen:
      final String placeId = routeSetting.arguments as String;
      return PageTransition(
          child: ReportPlaceScreen(placeId: placeId),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.reportReviewScreen:
      final reviewData = routeSetting.arguments as ReviewModel;
      return PageTransition(
          child: ReportReviewScreen(reviewData: reviewData),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.profileScreen:
      return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.myProfileScreen:
      return PageTransition(
          child: const MyProfileScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.languageScreen:
      return PageTransition(
          child: const LanguageScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.accSettingScreen:
      return PageTransition(
          child: const AccountSettingScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.addPlaceScreen:
      return PageTransition(
          child: const AddPlacesScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    case AppRoutes.locationScreen:
      return PageTransition(
          child: const LocationScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));

    default:
      return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300));
  }
}
