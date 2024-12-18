import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_selectable_staggered_grid.dart';
import 'package:kualiva/data/model/ui_model/f_n_b_asset_model.dart';

class OnboardingPickCuisine extends StatelessWidget {
  const OnboardingPickCuisine({
    super.key,
    this.cuisineData,
    required this.selectedIndexes,
    required this.hintText,
    this.onHintPressed,
    required this.onSelected,
  });

  final FNBAssetModel? cuisineData;
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
          bgImages: cuisineData!.listAssetBg ?? [],
          iconImages: brightness == Brightness.light
              ? cuisineData!.listAssetLight
              : cuisineData!.listAssetDark,
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
