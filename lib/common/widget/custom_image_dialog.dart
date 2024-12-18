import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';

Future<void> customImageDialog({
  required BuildContext context,
  required void Function()? onPressedGallery,
  required void Function()? onPressedCamera,
  required VoidCallback? onButtonPressed,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: Icon(
        Icons.info_outline,
        size: 50.h,
        color: theme(context).colorScheme.primary,
      ),
      title: Text(context.tr("common.select_image_media")),
      content: SizedBox(
        height: 150.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _attachMediaButton(
                Icons.image, context.tr("common.gallery"), onPressedGallery),
            _attachMediaButton(
                Icons.camera_alt, context.tr("common.camera"), onPressedCamera)
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: () => onButtonPressed!(),
          child: SizedBox(
            width: 75.h,
            height: 30.h,
            child: Center(
              child: Text(
                context.tr("common.select_image_media_btn"),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _attachMediaButton(
    IconData icon, String label, void Function()? onPressed) {
  return SizedBox(
    height: 75.h,
    width: 75.h,
    child: Card(
      elevation: 5.h,
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 30.h,
              ),
              Text(label),
            ],
          ),
        ),
      ),
    ),
  );
}
