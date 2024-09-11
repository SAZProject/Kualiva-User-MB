import 'package:flutter/material.dart';
import 'package:like_it/auth/device_permission_screen.dart';
import 'package:like_it/auth/otp_page_screen.dart';
import 'package:like_it/auth/sign_in_screen.dart';
import 'package:like_it/auth/sign_up_screen.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/review_model.dart';
import 'package:like_it/presentation/f_n_b/f_n_b.dart';
import 'package:like_it/presentation/f_n_b/f_n_b_detail_menu_screen.dart';
import 'package:like_it/presentation/f_n_b/f_n_b_detail_screen.dart';
import 'package:like_it/presentation/home/home_navigation.dart';
import 'package:like_it/presentation/report/report_place_screen.dart';
import 'package:like_it/presentation/report/report_review_screen.dart';
import 'package:like_it/presentation/review/review_form_screen.dart';
import 'package:like_it/presentation/review/review_screen.dart';
import 'package:like_it/splash_onboarding/onboarding.dart';
import 'package:like_it/splash_onboarding/splash.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  static const String splashScreen = "/splash_screen";

  static const String onBoardingScreen = "/onboarding";

  static const String signInScreen = "/sign_in_screen";

  static const String signUpScreen = "/sign_up_screen";

  static const String otpScreen = "/otp_screen";

  static const String doneScreen = "/done_screen";

  static const String devicePermissionScreen = "/device_permission_screen";

  static const String homeNavigationScreen = "/home_nav_screen";

  static const String fnbScreen = "/f_n_b_screen";

  static const String fnbDetailScreen = "/f_n_b_detail_screen";

  static const String fnbDetailMenuScreen = "/f_n_b_detail_menu_screen";

  static const String reviewScreen = "/review_screen";

  static const String reviewFormScreen = "/review_form_screen";

  static const String reportPlaceScreen = "/report_place_screen";

  static const String reportReviewScreen = "/report_review_screen";
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
          child: const HomeNavigation(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));
    case AppRoutes.fnbScreen:
      return PageTransition(
          child: const FNBScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));
    case AppRoutes.fnbDetailScreen:
      final fnbModel = routeSetting.arguments as FNBModel;
      return PageTransition(
          child: FNBDetailScreen(fnbModel: fnbModel),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));
    case AppRoutes.fnbDetailMenuScreen:
      final listImageMenu = routeSetting.arguments as List<String>;
      return PageTransition(
          child: FNBDetailMenuScreen(listImageMenu: listImageMenu),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));
    case AppRoutes.reviewScreen:
      final fnbModel = routeSetting.arguments as FNBModel;
      return PageTransition(
          child: ReviewScreen(fnbModel: fnbModel),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));
    case AppRoutes.reviewFormScreen:
      final fnbModel = routeSetting.arguments as FNBModel;
      return PageTransition(
          child: ReviewFormScreen(fnbModel: fnbModel),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));
    case AppRoutes.reportPlaceScreen:
      final fnbModel = routeSetting.arguments as FNBModel;
      return PageTransition(
          child: ReportPlaceScreen(fnbModel: fnbModel),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));
    case AppRoutes.reportReviewScreen:
      final reviewData = routeSetting.arguments as ReviewModel;
      return PageTransition(
          child: ReportReviewScreen(reviewData: reviewData),
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
