import 'package:flutter/material.dart';
import 'package:like_it/app_routes.dart';
import 'package:like_it/auth/device_permission_screen.dart';
import 'package:like_it/auth/otp_page_screen.dart';
import 'package:like_it/auth/sign_in_screen.dart';
import 'package:like_it/auth/sign_up_screen.dart';
import 'package:like_it/common/screen/location_screen.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/review_model.dart';
import 'package:like_it/data/model/ui_model/filters_model.dart';
import 'package:like_it/data/model/ui_model/home_event_model.dart';
import 'package:like_it/onboarding_screen/onboarding_verifying_user.dart';
import 'package:like_it/presentation/home/home_event_detail_screen.dart';
import 'package:like_it/presentation/home/home_event_screen.dart';
import 'package:like_it/presentation/places/add_places_screen.dart';
import 'package:like_it/presentation/places/f_n_b/f_n_b.dart';
import 'package:like_it/presentation/places/f_n_b/f_n_b_cuisine.dart';
import 'package:like_it/presentation/places/f_n_b/f_n_b_detail_menu_screen.dart';
import 'package:like_it/presentation/places/f_n_b/f_n_b_detail_screen.dart';
import 'package:like_it/presentation/home/home_navigation.dart';
import 'package:like_it/presentation/places/f_n_b/f_n_b_filters_screen.dart';
import 'package:like_it/presentation/profile/account_setting_screen.dart';
import 'package:like_it/presentation/profile/language_screen.dart';
import 'package:like_it/presentation/profile/my_profile_screen.dart';
import 'package:like_it/presentation/profile/profile_screen.dart';
import 'package:like_it/presentation/report/report_place_screen.dart';
import 'package:like_it/presentation/report/report_review_screen.dart';
import 'package:like_it/presentation/review/review_form_screen.dart';
import 'package:like_it/presentation/review/review_screen.dart';
import 'package:like_it/onboarding_screen/onboarding_screen.dart';
import 'package:like_it/splash_screen/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

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
          child: const HomeNavigation(),
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
          child: const FNBScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));
    case AppRoutes.fnbCuisineScreen:
      final cuisineTitle = routeSetting.arguments as String;
      return PageTransition(
          child: FNBCuisine(cuisineTitle: cuisineTitle),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 300));
    case AppRoutes.fnbFilterScreen:
      final filterModel = routeSetting.arguments as FiltersModel;
      return PageTransition(
          child: FNBFiltersScreen(getFilterModel: filterModel),
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
