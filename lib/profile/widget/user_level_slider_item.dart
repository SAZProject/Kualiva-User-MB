import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/profile/model/level_list_model.dart';

class UserLevelSliderItem extends StatelessWidget {
  const UserLevelSliderItem({
    super.key,
    required this.scrollIndex,
    required this.userLevel,
  });

  final int scrollIndex;
  final LevelListModel userLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.h,
      decoration: BoxDecoration(
        color: theme(context).colorScheme.onSecondaryContainer,
        boxShadow: [
          BoxShadow(
            color: appTheme.amber700,
            blurRadius: 10.h,
            spreadRadius: 2.5.h,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                userLevel.levelIcon,
                size: 100.h,
                color: userLevel.levelColor,
                shadows: [
                  Shadow(
                    color: userLevel.levelColor.withOpacity(0.8),
                    blurRadius: 50.0,
                  ),
                  Shadow(
                    color: userLevel.levelColor.withOpacity(0.4),
                    blurRadius: 75.0,
                  ),
                ],
              ),
              Text(
                userLevel.levelLabel,
                style: theme(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
