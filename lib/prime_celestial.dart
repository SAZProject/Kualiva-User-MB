import 'package:flutter/widgets.dart';
import 'package:kualiva/splash/splash_screen.dart';

class PrimeCelestial extends StatelessWidget {
  const PrimeCelestial({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TODO Create global bloc for dialog, snackbar, failure handler, point dialog, etc in main.dart
        // BlocBuilder(
        //   builder: (context, state) {
        //     return SizedBox();
        //   },
        // ),
        SplashScreen(),
      ],
    );
  }
}
