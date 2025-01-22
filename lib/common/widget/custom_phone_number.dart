import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/style/custom_text_style.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_text_form_field.dart';

class CustomPhoneNumber extends StatelessWidget {
  const CustomPhoneNumber({
    super.key,
    required this.textFormField,
    required this.country,
    required this.onPressed,
  });

  final CustomTextFormField textFormField;
  final Country country;
  final Function(Country) onPressed;

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
                style: CustomTextStyles(context).bodyMedium_15,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: 230.h,
            margin: EdgeInsets.only(left: 14.h),
            child: textFormField,
          ),
        ),
      ],
    );
    // return Row(
    //   children: [
    //     InkWell(
    //       onTap: () => _openCountryPicker(context),
    //       child: Row(
    //         children: [
    //           CountryPickerUtils.getDefaultFlagImage(country),
    //           Text(
    //             "+${country.phoneCode}",
    //             style: CustomTextStyles(context).bodyMedium_15,
    //           ),
    //         ],
    //       ),
    //     ),
    //     Expanded(
    //       child: Container(
    //         width: 230.h,
    //         margin: EdgeInsets.only(left: 14.h),
    //         child: TextFormField(
    //           focusNode: focusNode,
    //           autofocus: false,
    //           controller: controller,
    //           readOnly: readOnly,
    //           style: CustomTextStyles(context)
    //               .bodyLargeOnPrimaryContainer_03
    //               .copyWith(
    //                 color: theme(context).colorScheme.onPrimaryContainer,
    //               ),
    //           keyboardType: textInputType ?? TextInputType.phone,
    //           onTapOutside: (event) {
    //             if (focusNode != null) {
    //               focusNode?.unfocus();
    //             } else {
    //               FocusManager.instance.primaryFocus?.unfocus();
    //             }
    //           },
    //           decoration: InputDecoration(
    //             hintText:
    //                 hintText ?? context.tr("custom_phone_number.phone_number"),
    //             hintStyle:
    //                 CustomTextStyles(context).bodyLargeOnPrimaryContainer_06,
    //             enabledBorder: _defaultOutlinedInputBorder(context),
    //             focusedBorder: _defaultOutlinedInputBorder(context),
    //             disabledBorder: _defaultOutlinedInputBorder(context),
    //             border: _defaultOutlinedInputBorder(context),
    //             filled: true,
    //             fillColor: theme(context)
    //                 .colorScheme
    //                 .onSecondaryContainer
    //                 .withValues(0.6),
    //             isDense: false,
    //             contentPadding: EdgeInsets.all(5.h),
    //             suffixIcon: suffix,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget _countryPickerDialog(Country country) {
    return Row(
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
        SizedBox(width: 8.h),
        Flexible(
          child: Text(
            country.name,
            style: TextStyle(fontSize: 14.h),
          ),
        ),
      ],
    );
  }

  void _openCountryPicker(BuildContext context) {
    showDialog(
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
}
