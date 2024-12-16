import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/review/widget/review_filters_item.dart';
import 'package:like_it/review/widget/review_filters_modal.dart';

class ReviewFilterFeature extends StatelessWidget {
  const ReviewFilterFeature({
    super.key,
    required this.filterByCategory,
    required this.selectedCategory,
    required this.menuFilter,
  });

  final List<String> filterByCategory;

  final ValueNotifier<Set<String>> selectedCategory;

  final List<String> menuFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10.h,
            spacing: 10.h,
            children: List<Widget>.generate(
              filterByCategory.length,
              (index) {
                return ReviewFiltersItem(
                  label: context.tr(filterByCategory[index]),
                  multiSelect: true,
                  multiSelectedChoices: selectedCategory,
                );
              },
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            runSpacing: 10.h,
            spacing: 10.h,
            children: List<Widget>.generate(
              menuFilter.length,
              (index) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          const ReviewFiltersModal(),
                    ).then(
                      (value) {
                        if (value == null) return;

                        List<String?> resVal = value as List<String?>;
                        menuFilter.clear();
                        menuFilter.addAll(resVal as Iterable<String>);
                      },
                    );
                  },
                  child: FittedBox(
                    child: Card(
                      color: theme(context).colorScheme.onSecondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyle.roundedBorder20,
                        side: BorderSide(
                            color:
                                theme(context).colorScheme.onPrimaryContainer),
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
                                      color: theme(context).colorScheme.primary,
                                    )
                                  : const SizedBox(),
                              Text(
                                context.tr(menuFilter[index]),
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
          ),
        ],
      ),
    );
  }
}
