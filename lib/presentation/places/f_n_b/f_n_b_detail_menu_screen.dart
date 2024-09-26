import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';

class FNBDetailMenuScreen extends StatelessWidget {
  const FNBDetailMenuScreen({super.key, required this.listImageMenu});

  final List<String> listImageMenu;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _fnbDetailMenuAppBar(context),
        body: Container(
          width: double.maxFinite,
          height: Sizeutils.height,
          decoration: BoxDecoration(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            image: DecorationImage(
              image: AssetImage(ImageConstant.background2),
              fit: BoxFit.cover,
            ),
          ),
          child: _body(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _fnbDetailMenuAppBar(BuildContext context) {
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
          context.tr("f_n_b_detail.menu"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 55.h),
      padding: EdgeInsets.all(10.h),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _listDetailMenu(context),
        ],
      ),
    );
  }

  Widget _listDetailMenu(BuildContext context) {
    return Expanded(
      child: listImageMenu.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: listImageMenu.length,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (listImageMenu.isNotEmpty) {
                  return _listDetailMenuItem(context, listImageMenu[index]);
                }
                return const CustomEmptyState();
              },
            ),
    );
  }

  Widget _listDetailMenuItem(BuildContext context, String imageMenu) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration:
          CustomDecoration(context).outlineOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: imageMenu,
            height: 90.h,
            width: 160.h,
            alignment: Alignment.center,
            radius: BorderRadius.circular(10.h),
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr("f_n_b_detail.menu_title"),
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  context.tr("f_n_b_detail.menu_description"),
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
