import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/data/model/ui_model/loc_dropdown_model.dart';

DropdownMenuItem<LocDropdownModel> firstDropdownItem(context, String text) {
  return DropdownMenuItem(
    value: null,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CustomTextStyles(context).bodyMediumBlack900,
      ),
    ),
  );
}

DropdownMenuItem<LocDropdownModel> dataDropdownItem(
    context, LocDropdownModel value, String text) {
  return DropdownMenuItem(
    value: value,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CustomTextStyles(context).bodyMediumBlack900,
      ),
    ),
  );
}

DropdownMenuItem<LocDropdownModel> errorDropdownItem(context) {
  return DropdownMenuItem(
    value: null,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        "common.error".tr(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CustomTextStyles(context).bodyMediumBlack900,
      ),
    ),
  );
}

DropdownMenuItem<LocDropdownModel> loadingDropdownItem(context) {
  return DropdownMenuItem(
    value: null,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        "common.loading".tr(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CustomTextStyles(context).bodyMediumBlack900,
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
    borderRadius: BorderRadius.circular(20.0),
    menuMaxHeight: 300.0,
    value: selectedItem,
    onChanged: onChanged,
    items: items,
    dropdownColor: appTheme.white,
    underline: Container(),
  );
}
