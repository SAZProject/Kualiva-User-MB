import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/image_utility.dart';
import 'package:kualiva/common/widget/custom_image_dialog.dart';

class MyProfileUserImage extends StatelessWidget {
  const MyProfileUserImage({super.key, required this.userProfileImg});

  final ValueNotifier<List<String>> userProfileImg;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: userProfileImg,
      builder: (context, medias, child) {
        return SizedBox(
          width: 120.h,
          height: 120.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: medias.isEmpty ? "" : medias.first,
                height: 120.0,
                width: 120.0,
                boxFit: BoxFit.cover,
                radius: BorderRadius.circular(50.0),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 40.h,
                  height: 30.h,
                  decoration: CustomDecoration(context).primaryTRBdr,
                  child: IconButton(
                    alignment: Alignment.center,
                    tooltip: "Change Image",
                    icon: Icon(
                      Icons.edit,
                      size: 20.h,
                    ),
                    onPressed: () async {
                      await customImageDialog(
                        context: context,
                        onPressedGallery: () {
                          ImageUtility()
                              .getSingleMediaFromGallery(context, medias)
                              .then((value) => userProfileImg.value = value);
                          Navigator.pop(context);
                        },
                        onPressedCamera: () {
                          ImageUtility()
                              .getMediaFromCamera(context, medias)
                              .then((value) => userProfileImg.value = value);
                          Navigator.pop(context);
                        },
                        onButtonPressed: () => Navigator.pop(context),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
