import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/places/fnb/model/fnb_filter_toggle_model.dart';

class FnbFiltersGridFacilities extends StatefulWidget {
  const FnbFiltersGridFacilities({
    super.key,
    required this.label,
    required this.facilitiesDataset,
    required this.selectedFacilities,
  });

  final String label;
  final List<FnbFilterToggleModel> facilitiesDataset;
  final ValueNotifier<Set<String>> selectedFacilities;

  @override
  State<FnbFiltersGridFacilities> createState() =>
      _FnbFiltersGridFacilitiesState();
}

class _FnbFiltersGridFacilitiesState extends State<FnbFiltersGridFacilities> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.5.h),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: CustomDecoration(context).fillOnSecondaryContainer.copyWith(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: widget.label,
            useIcon: false,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 5.h,
                crossAxisSpacing: 2.5.h,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _gridMenuItem(
                    context,
                    widget.facilitiesDataset[0 + uiDataZeroVal()],
                    index,
                  );
                }

                if (index == 7) {
                  return _gridMenuItem(
                    context,
                    widget.facilitiesDataset[9 + uiDataNinthVal()],
                    index,
                  );
                }
                return _gridMenuItem(
                  context,
                  widget.facilitiesDataset[index + 2],
                  index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int uiDataZeroVal() {
    if (widget.selectedFacilities.value.contains("Open Now")) {
      return 1;
    } else if (widget.selectedFacilities.value.contains("Any")) {
      return 2;
    }
    return 0;
  }

  int uiDataNinthVal() {
    if (widget.selectedFacilities.value.contains("Drive Thru")) {
      return 1;
    } else if (widget.selectedFacilities.value.contains("Both")) {
      return 2;
    }
    return 0;
  }

  void _gridOnPressed(int index, String labelValue) {
    setState(() {
      switch (index) {
        case 0:
          if (labelValue == widget.facilitiesDataset[0].label) {
            widget.selectedFacilities.value.remove(labelValue);
            widget.selectedFacilities.value
                .add(widget.facilitiesDataset[1].label);
          }
          if (labelValue == widget.facilitiesDataset[1].label) {
            widget.selectedFacilities.value.remove(labelValue);
            widget.selectedFacilities.value
                .add(widget.facilitiesDataset[2].label);
          }
          if (labelValue == widget.facilitiesDataset[2].label) {
            widget.selectedFacilities.value.remove(labelValue);
            widget.selectedFacilities.value
                .add(widget.facilitiesDataset[0].label);
          }
          break;
        case 7:
          if (labelValue == widget.facilitiesDataset[9].label) {
            widget.selectedFacilities.value.remove(labelValue);
            widget.selectedFacilities.value
                .add(widget.facilitiesDataset[10].label);
          }
          if (labelValue == widget.facilitiesDataset[10].label) {
            widget.selectedFacilities.value.remove(labelValue);
            widget.selectedFacilities.value
                .add(widget.facilitiesDataset[11].label);
          }
          if (labelValue == widget.facilitiesDataset[11].label) {
            widget.selectedFacilities.value.remove(labelValue);
            widget.selectedFacilities.value
                .add(widget.facilitiesDataset[9].label);
          }
          break;
        default:
          if (widget.selectedFacilities.value.contains(labelValue)) {
            widget.selectedFacilities.value.remove(labelValue);
          } else {
            widget.selectedFacilities.value.add(labelValue);
          }
          break;
      }
    });
  }

  IconData iconLogic(
      int index, String labelValue, FnbFilterToggleModel facilitiesData) {
    if (index == 0) {
      if (labelValue == widget.facilitiesDataset[0].label) {
        return widget.facilitiesDataset[0].icon!;
      }
      if (labelValue == widget.facilitiesDataset[1].label) {
        return widget.facilitiesDataset[1].icon!;
      }
      if (labelValue == widget.facilitiesDataset[2].label) {
        return widget.facilitiesDataset[2].icon!;
      }
    }
    return facilitiesData.icon ?? Icons.info_outline;
  }

  String textLogic(int index) {
    return "";
  }

  Widget _gridMenuItem(
    BuildContext context,
    FnbFilterToggleModel facilitiesData,
    int index,
  ) {
    return InkWell(
      borderRadius: BorderRadiusStyle.roundedBorder10,
      onTap: () => _gridOnPressed(index, facilitiesData.label),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 5.h),
        decoration:
            widget.selectedFacilities.value.contains(facilitiesData.label)
                ? CustomDecoration(context).outlinePrimary
                : CustomDecoration(context).outlineOnPrimaryContainer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconLogic(index, facilitiesData.label, facilitiesData),
              color: theme(context).colorScheme.primary,
              size: 25.h,
            ),
            Text(
              facilitiesData.label,
              textAlign: TextAlign.center,
              style: CustomTextStyles(context).bodySmall12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
