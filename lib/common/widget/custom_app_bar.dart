import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height,
    this.leadingWidth,
    this.leadingIconColor,
    this.title,
    this.actions,
    this.onBackPressed,
  });

  final double? height;
  final double? leadingWidth;
  final Color? leadingIconColor;
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: height ?? 55.h,
      leadingWidth: leadingWidth ?? 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.only(left: 5.h),
        child: IconButton(
          iconSize: 25.h,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: leadingIconColor,
          ),
          onPressed: onBackPressed,
        ),
      ),
      title: title == null
          ? null
          : Padding(
              padding: EdgeInsets.zero,
              child: Text(
                title ?? "-",
                style: theme(context).textTheme.headlineSmall,
              ),
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(Sizeutils.width, height ?? 55.h);
}
