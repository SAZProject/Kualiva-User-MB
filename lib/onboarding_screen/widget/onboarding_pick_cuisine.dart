import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';

class OnboardingPickCuisine extends StatelessWidget {
  const OnboardingPickCuisine({
    super.key,
    required this.dummyImageData,
    required this.selectedIndexes,
    required this.hintText,
    this.onHintPressed,
    required this.onSelected,
  });

  final List<String> dummyImageData;
  final Set<int> selectedIndexes;
  final String hintText;
  final Function()? onHintPressed;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGridCuisine(context),
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

  Widget _buildGridCuisine(BuildContext context) {
    return Container(
      height: 400.h,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      width: double.maxFinite,
      child: dummyImageData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of items in each row
              ),
              itemCount: dummyImageData.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (dummyImageData.isNotEmpty) {
                  return InkWell(
                    onTap: () => onSelected(index),
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.h, vertical: 8.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedIndexes.contains(index)
                              ? theme(context).colorScheme.primary
                              : Colors.transparent,
                          width: selectedIndexes.contains(index) ? 2.h : 0.0,
                        ),
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
                      child: CustomImageView(
                        imagePath: dummyImageData[index],
                        height: 120.h,
                        width: 100.h,
                        radius: BorderRadius.circular(10.h),
                      ),
                    ),
                  );
                }
                return const CustomEmptyState();
              },
            ),
    );
  }
}
