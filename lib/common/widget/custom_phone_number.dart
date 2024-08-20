import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/style/custom_text_style.dart';
import 'package:like_it/common/style/theme_helper.dart';

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
            width: 230,
            margin: const EdgeInsets.only(left: 14.0),
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
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: theme.colorScheme.onPrimaryContainer.withOpacity(0.6),
          width: 1,
        ),
      );

  Widget _countryPickerDialog(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: 60.0,
            child: Text(
              "+${country.phoneCode}",
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              country.name,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      );

  void _openCountryPicker(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          searchInputDecoration: InputDecoration(
            hintText: context.tr("custom_phone_number.search"),
            hintStyle: const TextStyle(fontSize: 14),
          ),
          isSearchable: true,
          title: Text(
            context.tr("custom_phone_number.select_phone_code"),
            style: const TextStyle(fontSize: 14.0),
          ),
          onValuePicked: (value) => onPressed(value),
          itemBuilder: _countryPickerDialog,
        ),
      );
}
