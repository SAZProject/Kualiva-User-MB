import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/review/enum/review_order_num.dart';
import 'package:kualiva/review/enum/review_selected_user_enum.dart';
import 'package:kualiva/review/widget/review_filters_item.dart';
import 'package:kualiva/review/widget/review_filters_modal.dart';

class ReviewFilterFeature extends StatefulWidget {
  const ReviewFilterFeature({
    super.key,
    required this.selectedUser,
    required this.withMedia,
    required this.rating,
    required this.order,
  });

  final ValueNotifier<ReviewSelectedUserEnum?> selectedUser;
  final ValueNotifier<bool?> withMedia;
  final ValueNotifier<int?> rating;
  final ValueNotifier<ReviewOrderEnum?> order;

  @override
  State<ReviewFilterFeature> createState() => _ReviewFilterFeatureState();
}

class _ReviewFilterFeatureState extends State<ReviewFilterFeature> {
  ValueNotifier<ReviewSelectedUserEnum?> get selectedUser =>
      widget.selectedUser;
  ValueNotifier<bool?> get withMedia => widget.withMedia;
  ValueNotifier<int?> get rating => widget.rating;
  ValueNotifier<ReviewOrderEnum?> get order => widget.order;

  final Map<String, ReviewSelectedUserEnum> selectedUserMap = Map.from({
    'review.filter_user': ReviewSelectedUserEnum.user,
    'review.filter_kualiva': ReviewSelectedUserEnum.kualiva,
  });

  final menuFilter = ValueNotifier<List<String>>([
    "review.filter_time",
    "review.filter_media",
    "review.filter_rating",
  ]);

  final selectedUserSet = ValueNotifier<Set<String>>({});

  void selectedUserChange() {
    selectedUser.value =
        selectedUserMap[selectedUserSet.value.firstOrNull ?? ''];
  }

  @override
  void initState() {
    super.initState();
    selectedUserSet.addListener(selectedUserChange);
  }

  @override
  void dispose() {
    super.dispose();
    selectedUserSet.removeListener(selectedUserChange);
    selectedUserSet.dispose();
    menuFilter.dispose();
  }

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
              selectedUserMap.length,
              (index) {
                return ReviewFiltersItem(
                  label: context.tr(selectedUserMap.keys.elementAt(index)),
                  multiSelectedChoices: selectedUserSet,
                );
              },
            ),
          ),
          ValueListenableBuilder(
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
                          builder: (BuildContext context) {
                            return ReviewFiltersModal(
                              menuFilter: menuFilter,
                              withMedia: withMedia,
                              rating: rating,
                              order: order,
                            );
                          },
                        );
                      },
                      child: FittedBox(
                        child: Card(
                          color:
                              theme(context).colorScheme.onSecondaryContainer,
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
                                          color: theme(context)
                                              .colorScheme
                                              .primary,
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
            },
          ),
        ],
      ),
    );
  }
}
