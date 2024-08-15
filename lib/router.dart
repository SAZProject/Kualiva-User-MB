import 'package:flutter/material.dart';
import 'package:like_it/splash_onboarding/splash.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings routeSetting) {
  switch (routeSetting.name) {
    case SplashScreen.routeName:
      return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.scale,
          duration: const Duration(milliseconds: 300));
    default:
      return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.scale,
          duration: const Duration(milliseconds: 300));
  }
}
