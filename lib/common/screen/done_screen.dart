import 'package:flutter/material.dart';
import 'package:like_it/common/utility/image_constant.dart';
import 'package:like_it/common/utility/sized_utils.dart';
import 'package:like_it/common/widget/custom_image_view.dart';
import 'package:like_it/router.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key});

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 6),
      () {
        Navigator.pushNamed(context, AppRoutes.devicePermissionScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.done,
                height: 300.h,
                width: double.maxFinite,
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
