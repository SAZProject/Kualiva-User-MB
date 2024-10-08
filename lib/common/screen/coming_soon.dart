import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Container(
          //     width: double.maxFinite,
          //     decoration: BoxDecoration(
          //       color: theme(context).scaffoldBackgroundColor,
          //       image: DecorationImage(
          //         image: AssetImage(ImageConstant.background2),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent),
            // backgroundColor: Colors.transparent,
            body: SizedBox(
              child: Center(
                child: Text(
                  context.tr("common.coming_soon"),
                  style: CustomTextStyles(context).titleLarge_22,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
