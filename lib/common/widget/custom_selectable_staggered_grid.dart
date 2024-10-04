import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:like_it/common/app_export.dart';

class CustomSelectableStaggeredGrid extends StatelessWidget {
  const CustomSelectableStaggeredGrid({
    super.key,
    required this.totalItem,
    required this.bgImages,
    required this.iconImages,
    required this.labels,
    required this.isEmpty,
    this.selectedIndexes,
    this.onHintPressed,
    this.onSelected,
    this.alignment,
    this.controller,
  });

  final int totalItem;
  final List<String> bgImages;
  final List<String> iconImages;
  final List<String> labels;
  final bool isEmpty;
  final Set<int>? selectedIndexes;
  final Function()? onHintPressed;
  final Function(int)? onSelected;
  final Alignment? alignment;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildGridViewCuisine(context),
          )
        : _buildGridViewCuisine(context);
  }

  Widget _buildGridViewCuisine(BuildContext context) {
    return Container(
      height: 400.h,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      width: double.maxFinite,
      child: isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              controller: controller,
              child: StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                axisDirection: AxisDirection.down,
                children: List.generate(
                  totalItem,
                  (index) {
                    if (index == (totalItem - 2)) {
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 1,
                        child: _buildGridItemCuisine(
                          context,
                          index,
                          true,
                          bgImages[index],
                          iconImages[index],
                          labels[index],
                        ),
                      );
                    }
                    if (index == (totalItem - 1)) {
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 1,
                        child: _buildGridItemCuisine(
                          context,
                          index,
                          true,
                          bgImages[index],
                          iconImages[index],
                          labels[index],
                        ),
                      );
                    }
                    return StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: _buildGridItemCuisine(
                        context,
                        index,
                        false,
                        bgImages[index],
                        iconImages[index],
                        labels[index],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildGridItemCuisine(
    BuildContext context,
    int index,
    bool lastItem,
    String bgImage,
    String iconImage,
    String label,
  ) {
    return InkWell(
      onTap: () => onSelected != null ? onSelected!(index) : {},
      borderRadius: BorderRadiusStyle.roundedBorder10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedIndexes == null
                ? Colors.transparent
                : selectedIndexes!.contains(index)
                    ? theme(context).colorScheme.primary
                    : Colors.transparent,
            width: selectedIndexes == null
                ? 0.0
                : selectedIndexes!.contains(index)
                    ? 2.h
                    : 0.0,
          ),
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: bgImage,
              height: 120.h,
              width: lastItem ? double.maxFinite : 100.h,
              radius: BorderRadius.circular(10.h),
            ),
            DecoratedBox(
              decoration: CustomDecoration(context)
                  .fillOnSecondaryContainer_06
                  .copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomImageView(
                      imagePath: iconImage,
                      radius: BorderRadius.circular(10.h),
                    ),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles(context).bodySmall12.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
