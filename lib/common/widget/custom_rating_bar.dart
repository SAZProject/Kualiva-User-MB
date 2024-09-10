import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_it/common/app_export.dart';

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar(
      {super.key,
      this.alignment,
      this.ignoreGesture,
      this.initialRating,
      this.itemSize,
      this.itemCount,
      this.color,
      this.unselectedColor,
      this.onRatingUpdate});

  final Alignment? alignment;
  final bool? ignoreGesture;
  final double? initialRating;
  final double? itemSize;
  final int? itemCount;
  final Color? color;
  final Color? unselectedColor;
  final Function(double)? onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget get ratingBarWidget => RatingBar.builder(
        ignoreGestures: ignoreGesture ?? false,
        initialRating: initialRating ?? 0,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemSize: itemSize ?? 12.h,
        itemCount: itemCount ?? 5,
        updateOnDrag: true,
        unratedColor: unselectedColor,
        itemBuilder: (context, index) {
          return Icon(
            Icons.star,
            color: color,
          );
        },
        onRatingUpdate: (value) {
          onRatingUpdate!.call(value);
        },
      );
}
