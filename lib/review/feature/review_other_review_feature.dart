import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/review_model.dart';
import 'package:like_it/review/widget/review_view.dart';
import 'package:like_it/review/widget/special_review_view.dart';

class ReviewOtherReviewFeature extends StatelessWidget {
  const ReviewOtherReviewFeature({super.key, required this.listReviewData});

  final List<ReviewModel> listReviewData;

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
            child: listReviewData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listReviewData.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (listReviewData.isNotEmpty) {
                        ReviewModel reviewData = listReviewData[index];
                        if (reviewData.specialReview) {
                          return SpecialReviewView(reviewData: reviewData);
                        }
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          child: ReviewView(reviewData: reviewData),
                        );
                      }
                      return const CustomEmptyState();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
