import 'package:flutter/material.dart';
import 'package:like_it/common/utility/image_constant.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash-screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 250.0,
              height: 200.0,
              child: Image.asset(
                ImageConstant.appLogo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
