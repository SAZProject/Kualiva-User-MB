import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final IconData prefixIcon;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.h),
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: Sizeutils.width,
          height: 30.h,
          child: Row(
            children: [
              Icon(
                prefixIcon,
                size: 15.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: Text(
                  label,
                  style: theme(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              Visibility(
                visible: suffixIcon != null,
                child: Icon(
                  suffixIcon,
                  size: 15.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
