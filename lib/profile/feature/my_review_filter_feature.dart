import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/profile/widget/my_review_modal.dart';

class MyReviewFilterFeature extends StatelessWidget {
  const MyReviewFilterFeature({
    super.key,
    required this.menuFilter,
  });

  final ValueNotifier<List<String>> menuFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      child: ValueListenableBuilder(
          valueListenable: menuFilter,
          builder: (context, value, child) {
            return Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              runSpacing: 10.h,
              spacing: 10.h,
              children: List<Widget>.generate(
                value.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => MyReviewModal(
                          menuFilter: menuFilter,
                        ),
                      );
                    },
                    child: FittedBox(
                      child: Card(
                        color: theme(context).colorScheme.onSecondaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusStyle.roundedBorder20,
                          side: BorderSide(
                              color: theme(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                        clipBehavior: Clip.hardEdge,
                        elevation: 5.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 5.h),
                          child: Center(
                            child: Row(
                              children: [
                                index == 2
                                    ? Icon(
                                        Icons.star,
                                        size: 20.h,
                                        color:
                                            theme(context).colorScheme.primary,
                                      )
                                    : const SizedBox(),
                                Text(
                                  value[index].contains(".")
                                      ? context.tr(value[index])
                                      : value[index],
                                  textAlign: TextAlign.center,
                                  style: theme(context).textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 20.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
