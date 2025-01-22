import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/review/bloc/review_place_my_read_bloc.dart';
import 'package:kualiva/review/widget/review_view.dart';

class MyReviewList extends StatelessWidget {
  const MyReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration: CustomDecoration(context).fillOnSecondaryContainer.copyWith(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withValues(alpha: 0.6),
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      child: BlocBuilder<ReviewPlaceMyReadBloc, ReviewPlaceMyReadState>(
          builder: (context, state) {
        if (state is ReviewPlaceMyReadFailure) {
          return CustomEmptyState();
        }

        if (state is! ReviewPlaceMyReadSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        return Container(
          height: 150.h,
          margin: EdgeInsets.symmetric(horizontal: 5.h),
          width: double.maxFinite,
          child: Center(
            child: ReviewView(reviewData: state.reviewPlace),
          ),
        );
      }),
    );
  }
}
