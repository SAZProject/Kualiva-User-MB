import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/data/model/ui_model/loc_dropdown_model.dart';

DropdownMenuItem<LocDropdownModel> firstDropdownItem(context, String text) {
  return DropdownMenuItem(
    value: null,
    child: SizedBox(
      width: double.maxFinite,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme(context).textTheme.bodyMedium,
      ),
    ),
  );
}

DropdownMenuItem<LocDropdownModel> dataDropdownItem(
    context, LocDropdownModel value, String text) {
  return DropdownMenuItem(
    value: value,
    child: SizedBox(
      width: double.maxFinite,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme(context).textTheme.bodyMedium,
      ),
    ),
  );
}

DropdownMenuItem<LocDropdownModel> errorDropdownItem(context) {
  return DropdownMenuItem(
    value: null,
    child: SizedBox(
      width: double.maxFinite,
      child: Text(
        "common.error".tr(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme(context).textTheme.bodyMedium,
      ),
    ),
  );
}

DropdownMenuItem<LocDropdownModel> loadingDropdownItem(context) {
  return DropdownMenuItem(
    value: null,
    child: SizedBox(
      width: double.maxFinite,
      child: Text(
        "common.loading".tr(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme(context).textTheme.bodyMedium,
      ),
    ),
  );
}

Widget filterDropdownButton(
    context,
    LocDropdownModel? selectedItem,
    List<DropdownMenuItem<LocDropdownModel>> items,
    void Function(LocDropdownModel?)? onChanged) {
  return DropdownButton(
    isExpanded: true,
    borderRadius: BorderRadius.circular(20.h),
    menuMaxHeight: 300.h,
    value: selectedItem,
    onChanged: onChanged,
    items: items,
    dropdownColor: theme(context).colorScheme.onSecondaryContainer,
    underline: const SizedBox(),
  );
}
