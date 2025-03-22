import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';

class SearchMediaItem extends StatelessWidget {
  const SearchMediaItem({super.key, required this.image, required this.label});

  final String image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.h,
      margin: EdgeInsets.all(5.h),
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder10,
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              alignment: Alignment.center,
              imagePath: image,
              height: 80.h,
              width: 80.h,
              radius: BorderRadius.circular(50.h),
              boxFit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                label,
                style: theme(context).textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
