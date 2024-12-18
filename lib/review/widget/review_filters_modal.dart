import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/common/widget/custom_radio_button.dart';

class ReviewFiltersModal extends StatefulWidget {
  const ReviewFiltersModal({super.key});

  @override
  State<ReviewFiltersModal> createState() => _ReviewFiltersModalState();
}

class _ReviewFiltersModalState extends State<ReviewFiltersModal> {
  List<String> listFilterTime = [
    "review.filter_time_1",
    "review.filter_time_2",
  ];
  String? selectedFilterTime;

  List<String> listFilterMedia = [
    "review.filter_media_1",
  ];
  String? selectedFilterMedia;

  List<String> listFilterRating = [
    "review.filter_rating_1",
    "review.filter_rating_2",
    "review.filter_rating_3",
    "review.filter_rating_4",
    "review.filter_rating_5",
    "review.filter_rating_6",
    "review.filter_rating_7",
  ];
  String? selectedFilterRating;

  void _resetValue() {
    setState(() {
      selectedFilterTime = null;
      selectedFilterMedia = null;
      selectedFilterRating = null;
    });
  }

  void _saveButton() {
    List<String?> filterResult = [
      selectedFilterTime,
      selectedFilterMedia,
      selectedFilterRating,
    ];
    Navigator.pop(context, filterResult);
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
                        itemCount: listFilterTime.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildSectionChoices(
                            context,
                            context.tr(listFilterTime[index]),
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
                        itemCount: listFilterRating.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildSectionChoices(
                            context,
                            context.tr(listFilterRating[index]),
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
    String? value,
    String? groupVal,
    Function(String) onChange,
  ) {
    return CustomRadioButton(
      text: value,
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
