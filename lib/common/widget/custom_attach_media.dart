import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/image_utility.dart';
import 'package:kualiva/common/widget/custom_fullscreen_image.dart';
import 'package:kualiva/common/widget/custom_image_dialog.dart';

class CustomAttachMedia extends StatelessWidget {
  const CustomAttachMedia({
    super.key,
    required this.headerLabel,
    required this.listImages,
    this.defaultContentType = "common.attach_media_image",
    this.defaultContentMax = "common.max_media",
    this.limit = 5,
    this.hasRule = false,
    this.ruleContent = "",
    this.onPressedGallery,
    this.onPressedCamera,
    this.onCancelPressed,
    this.onRemovePressed,
  });

  final String headerLabel;
  final List<String> listImages;
  final String defaultContentType;
  final String defaultContentMax;
  final int? limit;
  final bool hasRule;
  final String ruleContent;
  final void Function()? onPressedGallery;
  final void Function()? onPressedCamera;
  final void Function()? onCancelPressed;
  final Function(int)? onRemovePressed;

  @override
  Widget build(BuildContext context) {
    return _buildAttachMedia(context);
  }

  Widget _buildAttachMedia(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr(headerLabel),
            textAlign: TextAlign.center,
            style: theme(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          listImages.isEmpty
              ? _defaultAttachMedia(context)
              : _editableAttachMedia(context),
          SizedBox(height: 10.h),
          hasRule
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.tr(ruleContent),
                    textAlign: TextAlign.center,
                    style: theme(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : const SizedBox(),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _defaultAttachMedia(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadiusStyle.roundedBorder10,
      onTap: () async {
        await customImageDialog(
          context: context,
          onPressedGallery: onPressedGallery,
          onPressedCamera: onPressedCamera,
          onButtonPressed: onCancelPressed,
        );
      },
      child: Card(
        elevation: 5.h,
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(vertical: 5.h),
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration:
              CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.upload_file,
                size: 16.h,
              ),
              SizedBox(height: 4.h),
              Text(
                context.tr(defaultContentType),
                textAlign: TextAlign.center,
                style: theme(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                context.tr(defaultContentMax, namedArgs: {"index": "$limit"}),
                textAlign: TextAlign.center,
                style: theme(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editableAttachMedia(BuildContext context) {
    return SizedBox(
      height: 125.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: listImages.isEmpty
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        itemCount: listImages.isEmpty
            ? 1
            : listImages.length == limit
                ? limit
                : listImages.length + 1,
        itemBuilder: (context, index) {
          //TODO add waiting, empty, error state in future (maybe?)
          if (listImages.isEmpty) return const SizedBox();
          if ((index + 1) <= listImages.length) {
            return _attachMediaItem(
              context,
              listImages,
              listImages.indexOf(listImages[index]).toString(),
              listImages[index],
              index,
            );
          }
          return _attachMediaButton(context);
        },
      ),
    );
  }

  Widget _attachMediaItem(
    BuildContext context,
    List<String> listMediaFile,
    String id,
    String? mediaFilePath,
    int index,
  ) {
    return Container(
      width: 100.h,
      height: 100.h,
      margin: EdgeInsets.symmetric(horizontal: 2.5.h),
      decoration: CustomDecoration(context).fillOnSecondaryContainer,
      child: mediaFilePath != null
          ? Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomFullscreenImage(
                            id: id,
                            listMediaFile: listMediaFile,
                            backgroundDecoration: BoxDecoration(
                              color: theme(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                            initialIndex: index,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: "$mediaFilePath$index",
                      child: Image(
                        width: 100.h,
                        fit: BoxFit.cover,
                        image: ImageUtility().getImageType(mediaFilePath)!,
                        loadingBuilder: (context, child, event) {
                          if (event == null) return child;
                          return Center(
                            child: SizedBox(
                              width: 20.h,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                value: event.cumulativeBytesLoaded /
                                    (event.expectedTotalBytes ?? 1),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 30.h,
                    height: 30.h,
                    decoration: CustomDecoration(context).orange60Color,
                    child: Center(
                      child: IconButton(
                        onPressed: () => onRemovePressed == null
                            ? {}
                            : onRemovePressed!(index),
                        icon: Icon(
                          Icons.delete,
                          size: 15.h,
                        ),
                        color: theme(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Icon(Icons.add_a_photo, size: 50.h),
    );
  }

  Widget _attachMediaButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      width: 100.h,
      height: 100.h,
      child: InkWell(
        onTap: () async {
          await customImageDialog(
            context: context,
            onPressedGallery: onPressedGallery,
            onPressedCamera: onPressedCamera,
            onButtonPressed: onCancelPressed,
          );
        },
        child: Icon(Icons.add_a_photo, size: 50.h),
      ),
    );
  }
}
