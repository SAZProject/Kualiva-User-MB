import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_selectable_staggered_grid.dart';
import 'package:like_it/data/model/ui_model/cuisine_model.dart';

class OnboardingPickCuisine extends StatelessWidget {
  const OnboardingPickCuisine({
    super.key,
    this.cuisineData,
    required this.selectedIndexes,
    required this.hintText,
    this.onHintPressed,
    required this.onSelected,
  });

  final CuisineModel? cuisineData;
  final Set<int> selectedIndexes;
  final String hintText;
  final Function()? onHintPressed;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSelectableStaggeredGrid(
          totalItem: cuisineData!.totalItem,
          bgImages: cuisineData!.listCuisineBg,
          iconImages: brightness == Brightness.light
              ? cuisineData!.listCuisineLight
              : cuisineData!.listCuisineDark,
          labels: cuisineData!.listTitle,
          isEmpty: cuisineData!.listTitle.isEmpty,
          selectedIndexes: selectedIndexes,
          onSelected: onSelected,
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: InkWell(
            onTap: onHintPressed,
            child: Text(
              hintText,
              style: CustomTextStyles(context).bodySmallPrimary12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}
