import 'package:bounce/bounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/auth/bloc/auth_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/check_permission.dart';
import 'package:motion/motion.dart';
// import 'package:kualiva/common/utility/video_constant.dart';
// import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late VideoPlayerController _videoPlayerController;
  // late Future<void> _videoPlayerInitialized;

  double _logoHeight = 200.0;

  @override
  void initState() {
    super.initState();
    _checkPermission();
    _startBounceAnimation();
    // _videoPlayerController =
    //     VideoPlayerController.asset(VideoConstant.splashVideo);
    // _videoPlayerInitialized = _videoPlayerController.initialize().then(
    //   (value) {
    //     _videoPlayerController.addListener(_videoListener);
    //     _videoPlayerController.setVolume(0.0);
    //     _videoPlayerController.play();
    //   },
    // );
  }

  @override
  void dispose() {
    // _videoPlayerController.removeListener(_videoListener);
    // _videoPlayerController.dispose();
    super.dispose();
  }

  // void _videoListener() async {
  //   if (_videoPlayerController.value.position ==
  //       const Duration(seconds: 0, minutes: 0, hours: 0)) {}

  //   if (_videoPlayerController.value.position ==
  //       _videoPlayerController.value.duration) {
  //     if (!mounted) return;

  //     if (await CheckPermission.checkDevicePermission()) {
  //       if (!mounted) return;
  //       context.read<AuthBloc>().add(AuthStarted());
  //       return;
  //     }
  //     if (!mounted) return;
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, AppRoutes.devicePermissionScreen, (route) => false);
  //   }
  // }

  void _checkPermission() async {
    if (await CheckPermission.checkDevicePermission()) {
      if (!mounted) return;
      context.read<AuthBloc>().add(AuthStarted());
      return;
    }
    Future.delayed(
      Duration(seconds: 3),
      () {
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.devicePermissionScreen, (route) => false);
      },
    );
  }

  void _startBounceAnimation() {
    setState(() {
      _logoHeight = 100.h; // Set the target height for the bounce animation
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _logoHeight = 200.h; // Reset the height after the bounce animation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthTokenExist) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.homeNavigationScreen, (route) => false);
        }

        if (state is AuthTokenNotExist) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.signInScreen, (route) => false);
        }
      },
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.white,
          body: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _imageSplash(context),
    );
  }

  Widget _imageSplash(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.bounceOut,
              width: 200.h,
              height: _logoHeight.h,
              child: Motion(
                shadow: ShadowConfiguration(color: Colors.transparent),
                glare: GlareConfiguration.fromElevation(50),
                child: Bounce(
                  child: Image.asset(
                    ImageConstant.appLogo,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.all(5.h),
            child: Text(
              context.tr("splash.app_title"),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  // Widget _videoSplash(BuildContext context) {
  //   return FutureBuilder(
  //     future: _videoPlayerInitialized,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return FittedBox(
  //           fit: BoxFit.contain,
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(25.0),
  //             child: SizedBox(
  //               width: 250.h,
  //               height: 250.h,
  //               child: VideoPlayer(_videoPlayerController),
  //             ),
  //           ),
  //         );
  //       } else {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }
}
