import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/style/custom_text_style.dart';
import 'package:like_it/common/style/theme_helper.dart';
import 'package:like_it/common/utility/sized_utils.dart';

class CustomPhoneNumber extends StatelessWidget {
  const CustomPhoneNumber(
      {super.key,
      required this.country,
      required this.onPressed,
      this.controller});

  final Country country;
  final Function(Country) onPressed;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => _openCountryPicker(context),
          child: Row(
            children: [
              CountryPickerUtils.getDefaultFlagImage(country),
              Text(
                "+${country.phoneCode}",
                style: CustomTextStyles.bodyMedium_15,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: 230.h,
            margin: EdgeInsets.only(left: 14.h),
            child: TextFormField(
              focusNode: FocusNode(),
              autofocus: true,
              controller: controller,
              style: CustomTextStyles.bodyLargeOnPrimaryContainer_03,
              decoration: InputDecoration(
                hintText: context.tr("custom_phone_number.phone_number"),
                hintStyle: CustomTextStyles.bodyLargeOnPrimaryContainer_06,
                enabledBorder: _defaultOutlinedInputBorder(),
                disabledBorder: _defaultOutlinedInputBorder(),
                border: _defaultOutlinedInputBorder(),
                filled: true,
                fillColor: theme.colorScheme.onPrimaryContainer,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _defaultOutlinedInputBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide(
          color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
          width: 1,
        ),
      );

  Widget _countryPickerDialog(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Container(
            margin: EdgeInsets.only(left: 10.h),
            width: 60.h,
            child: Text(
              "+${country.phoneCode}",
              style: TextStyle(fontSize: 14.fontSize),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              country.name,
              style: TextStyle(fontSize: 14.h),
            ),
          ),
        ],
      );

  void _openCountryPicker(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          searchInputDecoration: InputDecoration(
            hintText: context.tr("custom_phone_number.search"),
            hintStyle: TextStyle(fontSize: 14.fontSize),
          ),
          isSearchable: true,
          title: Text(
            context.tr("custom_phone_number.select_phone_code"),
            style: TextStyle(fontSize: 14.fontSize),
          ),
          onValuePicked: (value) => onPressed(value),
          itemBuilder: _countryPickerDialog,
        ),
      );
}
