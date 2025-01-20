import 'package:flutter/material.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_rating_bar.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';

class FnbFiltersRating extends StatelessWidget {
  const FnbFiltersRating({
    super.key,
    required this.label,
    required this.ratingStar,
    this.onRatingUpdate,
  });

  final String label;
  final double ratingStar;
  final Function(double)? onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.5.h),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          CustomSectionHeader(
            label: label,
            useIcon: false,
          ),
          CustomRatingBar(
            alignment: Alignment.center,
            initialRating: ratingStar,
            itemSize: 50.h,
            color: theme(context).colorScheme.primary,
            onRatingUpdate: onRatingUpdate,
          ),
        ],
      ),
    );
  }
}
