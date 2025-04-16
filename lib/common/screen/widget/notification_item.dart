import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_text_style.dart';
import 'package:kualiva/common/style/theme_helper.dart';
import 'package:kualiva/common/utility/sized_utils.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    super.key,
    required this.index,
    required this.title,
    required this.content,
    required this.publishDate,
    this.onPressed,
    this.onDelete,
    this.onDismissed,
    this.confirmDismiss,
    required this.isExpanded,
  });

  final int index;
  final String title;
  final String content;
  final String publishDate;
  final Function()? onPressed;
  final Function()? onDelete;
  final Function(DismissDirection)? onDismissed;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("$index"),
      direction: DismissDirection.endToStart,
      background: SizedBox.shrink(),
      secondaryBackground: Padding(
        padding: EdgeInsets.only(right: 20.h),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete_outline,
            size: 25.h,
            color: Colors.red,
          ),
        ),
      ),
      onDismissed: onDismissed,
      confirmDismiss: confirmDismiss,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.5.h),
        child: SizedBox(
          width: double.maxFinite,
          child: ListTile(
            dense: true,
            minVerticalPadding: 0.0,
            minTileHeight: 75.h,
            minLeadingWidth: 0.0,
            visualDensity: VisualDensity.compact,
            title: Row(
              children: [
                SizedBox(
                  height: 50.h,
                  width: 50.h,
                ),
                SizedBox(width: 5.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: theme(context).textTheme.titleSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            publishDate,
                            style: CustomTextStyles(context).bodySmall10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Text(
                        content,
                        style: CustomTextStyles(context).bodySmall12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ],
            ),
            trailing: isExpanded
                ? InkWell(
                    onTap: onDelete,
                    child: Icon(
                      Icons.delete_outline,
                      size: 25.h,
                      color: Colors.red,
                    ),
                  )
                : null,
            onTap: onPressed,
          ),
        ),
      ),
    );
  }
}
