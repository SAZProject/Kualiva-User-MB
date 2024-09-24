import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';

class FNBFiltersItem extends StatelessWidget {
  const FNBFiltersItem({
    super.key,
    required this.label,
    this.onSelected,
    this.multiSelect = true,
    this.isWrap = false,
    this.singleSelectedChoices,
    this.multiSelectedChoices,
  });

  final String label;
  final Function(bool)? onSelected;
  final bool multiSelect;
  final bool isWrap;
  final ValueNotifier<String>? singleSelectedChoices;
  final ValueNotifier<Set<String>>? multiSelectedChoices;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      child: isWrap ? _buildWrapChip(context) : _buildChip(context),
    );
  }

  Widget _buildWrapChip(BuildContext context) {
    return FittedBox(
      child: _buildChip(context),
    );
  }

  Widget _buildChip(BuildContext context) {
    return multiSelect
        ? ValueListenableBuilder(
            valueListenable: multiSelectedChoices!,
            builder: (context, listenValue, child) => FilterChip(
              visualDensity: VisualDensity.compact,
              showCheckmark: false,
              labelPadding: EdgeInsets.zero,
              selected: multiSelectedChoices == null
                  ? false
                  : listenValue.contains(label),
              backgroundColor: theme(context).colorScheme.onSecondaryContainer,
              selectedColor: theme(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadiusStyle.roundedBorder5,
              ),
              label: _chipLabel(context),
              onSelected: onSelected ??
                  (value) {
                    final updatedSelectedChips = Set<String>.from(listenValue);
                    updatedSelectedChips.contains(label)
                        ? updatedSelectedChips.remove(label)
                        : updatedSelectedChips.add(label);
                    multiSelectedChoices!.value = updatedSelectedChips;
                  },
            ),
          )
        : ValueListenableBuilder(
            valueListenable: singleSelectedChoices!,
            builder: (context, listenValue, child) => ChoiceChip(
              visualDensity: VisualDensity.compact,
              showCheckmark: false,
              labelPadding: EdgeInsets.zero,
              selected: listenValue == label,
              backgroundColor: theme(context).colorScheme.onSecondaryContainer,
              selectedColor: theme(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadiusStyle.roundedBorder5,
              ),
              label: _chipLabel(context),
              onSelected: (value) {
                singleSelectedChoices!.value = label;
              },
            ),
          );
  }

  Widget _chipLabel(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: CustomTextStyles(context).bodyMedium_13,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
