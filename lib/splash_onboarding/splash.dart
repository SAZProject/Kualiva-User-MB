import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/utility/image_constant.dart';
import 'package:like_it/common/widget/sizd_spacer.dart';
import 'package:like_it/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamed(AppRoutes.onBoardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _splashWidget(),
    ));
  }

  Widget _splashWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 250.0,
            height: 200.0,
            child: Image.asset(
              ImageConstant.appLogo,
            ),
          ),
          sizedSpacer(context: context, height: 5.0),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              context.tr("splash.app_title".tr()),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          )
        ],
      ),
    );
  }
}
