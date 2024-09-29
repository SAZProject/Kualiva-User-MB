// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/utility/video_constant.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _videoPlayerInitialized;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset(VideoConstant.splashVideo);
    _videoPlayerInitialized = _videoPlayerController.initialize().then(
      (value) {
        _videoPlayerController.addListener(_videoListener);
        _videoPlayerController.setVolume(0.0);
        _videoPlayerController.play();
      },
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _videoListener() {
    if (_videoPlayerController.value.position ==
        const Duration(seconds: 0, minutes: 0, hours: 0)) {
      debugPrint('video Started');
    }

    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      debugPrint('video Ended');
      Navigator.of(context).pushNamed(AppRoutes.signInScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData.light(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _videoSplash(context),
    );
  }

  // Widget _imageSplash(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       SizedBox(
  //         width: 250.h,
  //         height: 200.h,
  //         child: Image.asset(
  //           ImageConstant.appLogo,
  //         ),
  //       ),
  //       SizedBox(height: 5.h),
  //       Padding(
  //         padding: EdgeInsets.all(5.h),
  //         child: Text(
  //           context.tr("splash.app_title"),
  //           style: Theme.of(context)
  //               .textTheme
  //               .displayMedium!
  //               .copyWith(fontWeight: FontWeight.bold),
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget _videoSplash(BuildContext context) {
    return FutureBuilder(
      future: _videoPlayerInitialized,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return FittedBox(
            fit: BoxFit.contain,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: SizedBox(
                width: 250.h,
                height: 250.h,
                child: VideoPlayer(_videoPlayerController),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
