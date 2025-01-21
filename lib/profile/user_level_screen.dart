import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/profile/widget/user_level_benefit.dart';
import 'package:kualiva/profile/widget/user_level_slider.dart';

class UserLevelScreen extends StatelessWidget {
  const UserLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _userLevelAppBar(context),
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
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            UserLevelSlider(),
            SizedBox(height: 5.h),
            UserLevelBenefit(),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _userLevelAppBar(BuildContext context) {
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
      actions: [
        IconButton(
          iconSize: 25.h,
          icon: const Icon(Icons.question_mark),
          onPressed: () {},
        ),
      ],
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          context.tr("user_level.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
