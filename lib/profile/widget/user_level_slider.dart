import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/profile/model/level_list_model.dart';
import 'package:kualiva/profile/widget/user_level_slider_item.dart';

class UserLevelSlider extends StatelessWidget {
  UserLevelSlider({super.key});

  final List<LevelListModel> levelList = [
    LevelListModel(
      levelIcon: Icons.diamond_outlined,
      levelLabel: "Iron",
      levelColor: Colors.blueGrey.shade100,
      isActive: false,
    ),
    LevelListModel(
      levelIcon: Icons.diamond_outlined,
      levelLabel: "Bronze",
      levelColor: Colors.brown.shade400,
      isActive: false,
    ),
    LevelListModel(
      levelIcon: Icons.diamond_outlined,
      levelLabel: "Silver",
      levelColor: Colors.grey.shade300,
      isActive: false,
    ),
    LevelListModel(
      levelIcon: Icons.diamond_outlined,
      levelLabel: "Gold",
      levelColor: Colors.yellowAccent,
      isActive: false,
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
      height: 250.h,
      child: CarouselSlider.builder(
        itemCount: 4,
        options: CarouselOptions(
          enlargeCenterPage: true,
          viewportFraction: 0.5,
          enableInfiniteScroll: false,
        ),
        itemBuilder: (context, index, realIndex) {
          debugPrint("index = $index, real index = $realIndex");
          return UserLevelSliderItem(
            scrollIndex: index,
            userLevel: levelList[index],
          );
        },
      ),
    );
  }
}
