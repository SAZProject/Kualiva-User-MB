import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/profile/model/level_benefit_model.dart';

class UserLevelBenefitItem extends StatelessWidget {
  const UserLevelBenefitItem({super.key, required this.levelBenefit});

  final LevelBenefitModel levelBenefit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330.h,
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
      decoration: CustomDecoration(context).backgroundBlur.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            levelBenefit.benefitTitle,
            style: theme(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 25.h),
          Text(
            levelBenefit.benefitContent,
            style: theme(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
