import 'package:flutter/material.dart';
import 'package:like_it/auth/device_permission_screen.dart';
import 'package:like_it/auth/otp_page_screen.dart';
import 'package:like_it/auth/sign_in_screen.dart';
import 'package:like_it/auth/sign_up_screen.dart';
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
    default:
      return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300));
  }
}
