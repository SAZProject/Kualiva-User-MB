import 'package:flutter/material.dart';
import 'package:like_it/splash_onboarding/onboarding.dart';
import 'package:like_it/splash_onboarding/splash.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  static const String splashScreen = "/splash_screen";

  static const String onBoardingScreen = "/onboarding";
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
    default:
      return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300));
  }
}
