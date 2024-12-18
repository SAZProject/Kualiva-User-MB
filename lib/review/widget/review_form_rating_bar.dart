import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_rating_bar.dart';

class ReportReviewRatingBar extends StatelessWidget {
  const ReportReviewRatingBar(
      {super.key, required this.ratingStar, this.onRatingUpdate});

  final double ratingStar;
  final Function(double)? onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomRatingBar(
        alignment: Alignment.center,
        initialRating: ratingStar,
        itemSize: 50.h,
        color: theme(context).colorScheme.primary,
        onRatingUpdate: onRatingUpdate,
      ),
    );
  }
}
