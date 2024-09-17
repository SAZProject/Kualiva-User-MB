import 'package:flutter/material.dart';
import 'package:like_it/common/utility/sized_utils.dart';

void showSnackBar(BuildContext context, IconData? icon, Color? iconColor,
    String? message, Color? messageColor) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(
              width: 10.h,
            ),
            Flexible(
              child: Text(
                message!,
                style: TextStyle(
                  color: messageColor!,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
}
