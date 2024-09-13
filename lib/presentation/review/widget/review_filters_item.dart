import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';

class ReviewFiltersItem extends StatelessWidget {
  const ReviewFiltersItem({
    super.key,
    required this.label,
    this.onSelected,
    this.multiSelect = true,
    this.singleSelectedChoices,
    this.multiSelectedChoices,
  });

  final String label;
  final Function(bool)? onSelected;
  final bool multiSelect;
  final String? singleSelectedChoices;
  final List<String>? multiSelectedChoices;

  @override
  Widget build(BuildContext context) {
    return multiSelect
        ? FittedBox(
            child: RawChip(
              visualDensity: VisualDensity.compact,
              showCheckmark: false,
              labelPadding: EdgeInsets.zero,
              selected: multiSelectedChoices == null
                  ? false
                  : multiSelectedChoices!.contains(label),
              backgroundColor: theme(context).colorScheme.onSecondaryContainer,
              selectedColor: theme(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(15.h),
              ),
              label: _chipLabel(context),
              onSelected: onSelected,
            ),
          )
        : FittedBox(
            child: ChoiceChip(
              visualDensity: VisualDensity.compact,
              showCheckmark: false,
              labelPadding: EdgeInsets.zero,
              selected: singleSelectedChoices == label,
              backgroundColor: theme(context).colorScheme.onSecondaryContainer,
              selectedColor: theme(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(15.h),
              ),
              label: _chipLabel(context),
              onSelected: onSelected,
            ),
          );
  }

  Widget _chipLabel(BuildContext context) {
    return multiSelect
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            child: Text(
              textAlign: TextAlign.center,
              label,
              style: theme(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 20.h,
                  color: appTheme.amber700,
                ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles(context).bodyMedium_13,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
  }
}
