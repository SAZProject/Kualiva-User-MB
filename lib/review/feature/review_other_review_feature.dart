import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/review/bloc/review_place_read_bloc.dart';
import 'package:kualiva/review/widget/review_view.dart';

class ReviewOtherReviewFeature extends StatelessWidget {
  const ReviewOtherReviewFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("review.other_review"),
            useIcon: false,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: _list(context),
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context) {
    return BlocBuilder<ReviewPlaceOtherReadBloc, ReviewPlaceOtherReadState>(
      builder: (context, state) {
        if (state is! ReviewPlaceOtherReadSuccess) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.reviewsPlace.isEmpty) {
          return CustomEmptyState();
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.reviewsPlace.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: ReviewView(reviewData: state.reviewsPlace[index]),
            );
          },
        );
      },
    );
  }
}
