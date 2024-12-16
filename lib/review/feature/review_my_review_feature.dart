import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/f_n_b_model.dart';

class ReviewMyReviewFeature extends StatelessWidget {
  const ReviewMyReviewFeature({super.key, required this.fnbData});

  final FNBModel fnbData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration: CustomDecoration(context).fillOnSecondaryContainer.copyWith(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("review.my_review"),
            useIcon: false,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.reviewFormScreen,
                  arguments: fnbData);
            },
            child: Container(
              height: 150.h,
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              width: double.maxFinite,
              child: Center(
                child: Text(
                  context.tr("review.no_review"),
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
