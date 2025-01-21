import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/profile/model/level_benefit_model.dart';
import 'package:kualiva/profile/widget/user_level_benefit_item.dart';

class UserLevelBenefit extends StatelessWidget {
  UserLevelBenefit({super.key});

  final List<LevelBenefitModel> benefitList = [
    LevelBenefitModel(
      benefitTitle: "Free ${Faker().food.dish()}",
      benefitContent: "Get your item at ${Faker().food.restaurant()}",
    ),
    LevelBenefitModel(
      benefitTitle: "Free ${Faker().food.dish()}",
      benefitContent: "Get your item at ${Faker().food.restaurant()}",
    ),
    LevelBenefitModel(
      benefitTitle: "Free ${Faker().food.dish()}",
      benefitContent: "Get your item at ${Faker().food.restaurant()}",
    ),
    LevelBenefitModel(
      benefitTitle: "Free ${Faker().food.dish()}",
      benefitContent: "Get your item at ${Faker().food.restaurant()}",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          _buildUserLevelSliderView(context),
        ],
      ),
    );
  }

  Widget _buildUserLevelSliderView(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: benefitList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
            child: UserLevelBenefitItem(levelBenefit: benefitList[index]),
          );
        },
      ),
    );
  }
}
