import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_radio_button.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedReason = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getData();
  }

  void _getData() async {
    if (mounted) {
      String locale = context.locale.toString();

      if (locale == "id") {
        _changeLanguageValue(locale);
      } else {
        _changeLanguageValue(locale);
      }
    }
  }

  void _changeLanguageValue(String value) {
    setState(() {
      selectedReason = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _myProfileAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      height: Sizeutils.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _switchLanguage(),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _myProfileAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.only(left: 5.h),
        child: IconButton(
          iconSize: 25.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          context.tr("lang.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _switchLanguage() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("lang.change_lang"),
            textAlign: TextAlign.center,
            style: theme(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),
          CustomRadioButton(
            text: context.tr("lang.indo"),
            value: "id",
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              _changeLanguageValue(value);
              context.setLocale(const Locale("id"));
            },
          ),
          SizedBox(height: 10.h),
          CustomRadioButton(
            text: context.tr("lang.eng"),
            value: "en",
            groupValue: selectedReason,
            padding: EdgeInsets.all(10.h),
            boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
            onChange: (value) {
              _changeLanguageValue(value);
              context.setLocale(const Locale("en"));
            },
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
