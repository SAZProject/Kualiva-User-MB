import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/data/model/review_model.dart';
import 'package:like_it/review/widget/review_view.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class SpecialReviewView extends StatelessWidget {
  const SpecialReviewView({super.key, required this.reviewData});

  final ReviewModel reviewData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      width: 330.h,
      child: OutlineGradientButton(
        padding: EdgeInsets.all(3.h),
        strokeWidth: 3.h,
        gradient: LinearGradient(
          begin: const Alignment(0.5, 0),
          end: const Alignment(0.5, 1),
          colors: [appTheme.yellowA700, theme(context).colorScheme.primary],
        ),
        corners: const Corners(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: ReviewView(reviewData: reviewData),
      ),
    );
  }
}
