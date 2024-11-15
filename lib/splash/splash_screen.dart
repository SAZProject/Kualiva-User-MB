import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_it/auth/bloc/auth_bloc.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/utility/check_permission.dart';
import 'package:like_it/common/utility/lelog.dart';
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
    _videoPlayerController.removeListener(_videoListener);
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _videoListener() async {
    if (_videoPlayerController.value.position ==
        const Duration(seconds: 0, minutes: 0, hours: 0)) {
      LeLog.pd(this, _videoListener, "Video Started");
    }

    if (_videoPlayerController.value.position ==
        _videoPlayerController.value.duration) {
      LeLog.pd(this, _videoListener, "Video Ended");

      if (!mounted) return;

      // Navigator.pushNamedAndRemoveUntil(
      //     context, AppRoutes.reviewScreen, (route) => false);
      // return;

      if (await CheckPermission.checkDevicePermission()) {
        if (!mounted) return;
        context.read<AuthBloc>().add(AuthStarted());
        return;
      }
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.devicePermissionScreen, (route) => false);
    }
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
        child: Theme(
          data: ThemeData.light(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: _body(),
          ),
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
