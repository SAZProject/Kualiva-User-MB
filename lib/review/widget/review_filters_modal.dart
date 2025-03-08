import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/common/widget/custom_radio_button.dart';
import 'package:kualiva/review/enum/review_order_num.dart';

class ReviewFiltersModal extends StatefulWidget {
  const ReviewFiltersModal({
    super.key,
    required this.menuFilter,
    required this.withMedia,
    required this.rating,
    required this.order,
  });

  final ValueNotifier<List<String>> menuFilter;
  final ValueNotifier<bool?> withMedia;
  final ValueNotifier<int?> rating;
  final ValueNotifier<ReviewOrderEnum?> order;

  @override
  State<ReviewFiltersModal> createState() => _ReviewFiltersModalState();
}

class _ReviewFiltersModalState extends State<ReviewFiltersModal> {
  ValueNotifier<List<String>> get menuFilter => widget.menuFilter;
  ValueNotifier<bool?> get withMedia => widget.withMedia;
  ValueNotifier<int?> get rating => widget.rating;
  ValueNotifier<ReviewOrderEnum?> get order => widget.order;

  final Map<String, ReviewOrderEnum> filterTimeMap = Map.from({
    'review.filter_time_1': ReviewOrderEnum.mostLikes,
    'review.filter_time_2': ReviewOrderEnum.recent,
  });

  String? selectedFilterTime;

  List<String> listFilterMedia = [
    "review.filter_media_1",
  ];
  String? selectedFilterMedia;

  final Map<String, int> filterRatingMap = Map.from({
    "review.filter_rating_1": 5,
    "review.filter_rating_2": 1,
    "review.filter_rating_3": 5,
    "review.filter_rating_4": 4,
    "review.filter_rating_5": 3,
    "review.filter_rating_6": 2,
    "review.filter_rating_7": 1
  });
  String? selectedFilterRating;

  void _resetValue() {
    List<String> filterResult = [
      "review.filter_time",
      "review.filter_media",
      "review.filter_rating",
    ];

    menuFilter.value.clear();
    menuFilter.value = filterResult;
  }

  void _saveButton() {
    List<String> filterResult = [
      selectedFilterTime ?? "review.filter_time",
      selectedFilterMedia ?? "review.filter_media",
      selectedFilterRating ?? "review.filter_rating",
    ];

    debugPrint("ANJING");
    debugPrint(selectedFilterMedia);
    debugPrint(selectedFilterRating);
    debugPrint(selectedFilterTime);

    withMedia.value = (selectedFilterMedia == null) ? null : true;
    rating.value = filterRatingMap[selectedFilterRating ?? ''];
    order.value = filterTimeMap[selectedFilterTime ?? ''];

    menuFilter.value.clear();
    menuFilter.value = filterResult;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _reviewFilterAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _filterView(context),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _reviewFilterAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: Text(
          context.tr("review.filter"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close,
            size: 20.h,
          ),
        )
      ],
    );
  }

  Widget _filterView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr("review.filter_time"),
                        textAlign: TextAlign.center,
                        style: theme(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10.h),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filterTimeMap.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildSectionChoices(
                            context,
                            context.tr(filterTimeMap.keys.elementAt(index)),
                            filterTimeMap.keys.elementAt(index),
                            selectedFilterTime,
                            (value) {
                              setState(() {
                                selectedFilterTime = value;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr("review.filter_media"),
                        textAlign: TextAlign.center,
                        style: theme(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10.h),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listFilterMedia.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildSectionChoices(
                            context,
                            context.tr(listFilterMedia[index]),
                            listFilterMedia[index],
                            selectedFilterMedia,
                            (value) {
                              setState(() {
                                selectedFilterMedia = value;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr("review.filter_rating"),
                        textAlign: TextAlign.center,
                        style: theme(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10.h),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filterRatingMap.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildSectionChoices(
                            context,
                            context.tr(filterRatingMap.keys.elementAt(index)),
                            filterRatingMap.keys.elementAt(index),
                            selectedFilterRating,
                            (value) {
                              setState(() {
                                selectedFilterRating = value;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: _buildSaveResetButton(
                          context, "review.reset_btn", () => _resetValue())),
                  Flexible(
                      child: _buildSaveResetButton(
                          context, "review.save_btn", () => _saveButton())),
                ],
              ),
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionChoices(
    BuildContext context,
    String? text,
    String? value,
    String? groupVal,
    Function(String) onChange,
  ) {
    return CustomRadioButton(
      text: text,
      value: value,
      groupValue: groupVal,
      iconSize: 10.h,
      padding: EdgeInsets.all(10.h),
      boxDecoration: RadioStyleHelper.fillOnSecondaryContainer(context),
      onChange: onChange,
    );
  }

  Widget _buildSaveResetButton(
      BuildContext context, String label, Function()? onPressed) {
    return SizedBox(
      height: 50.h,
      width: double.maxFinite,
      child: CustomGradientOutlinedButton(
        text: context.tr(label),
        outerPadding: EdgeInsets.symmetric(horizontal: 30.h),
        innerPadding: EdgeInsets.all(2.h),
        strokeWidth: 2.h,
        colors: [
          appTheme.yellowA700,
          theme(context).colorScheme.primary,
        ],
        textStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
        onPressed: onPressed,
      ),
    );
  }
}
