import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/dataset/f_n_b_filter_dataset.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_gradient_outlined_button.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/ui_model/filters_model.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_filters_item.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_filters_slider.dart';

class FNBFiltersScreen extends StatefulWidget {
  const FNBFiltersScreen({super.key});

  @override
  State<FNBFiltersScreen> createState() => _FNBFiltersScreenState();
}

class _FNBFiltersScreenState extends State<FNBFiltersScreen> {
  List<String> foodsCateg = FNBFilterDataset.fnbSubCategFoods;
  List<String> bvgsCateg = FNBFilterDataset.fnbSubCategBvg;

  FiltersModel filterModel = FiltersModel(
    radiusMin: 0.0,
    radiusMax: 100.0,
    priceRangeMin: 0.0,
    priceRangeMax: 1000000.0,
    ratingMin: 0.0,
    ratingMax: 5.0,
    foodSubCateg: [],
    bvgSubCateg: [],
  );

  ValueNotifier<Set<String>> selectedFoodSubCateg =
      ValueNotifier<Set<String>>({});
  ValueNotifier<Set<String>> selectedBvgSubCateg =
      ValueNotifier<Set<String>>({});

  late ValueNotifier<RangeValues> radiusNotifier;
  late ValueNotifier<RangeValues> priceRangeNotifier;
  late ValueNotifier<RangeValues> ratingNotifier;

  @override
  void initState() {
    super.initState();
    radiusNotifier = ValueNotifier<RangeValues>(
      RangeValues(filterModel.radiusMin, filterModel.radiusMax),
    );
    priceRangeNotifier = ValueNotifier<RangeValues>(
      RangeValues(filterModel.priceRangeMin, filterModel.priceRangeMax),
    );
    ratingNotifier = ValueNotifier<RangeValues>(
      RangeValues(filterModel.ratingMin.ceil().toDouble(),
          filterModel.ratingMax.ceil().toDouble()),
    );
  }

  @override
  void dispose() {
    radiusNotifier.dispose();
    priceRangeNotifier.dispose();
    ratingNotifier.dispose();
    selectedFoodSubCateg.dispose();
    selectedBvgSubCateg.dispose();
    super.dispose();
  }

  void _resetValue() {
    radiusNotifier.value = const RangeValues(0.0, 100.0);
    priceRangeNotifier.value = const RangeValues(0.0, 1000000.0);
    ratingNotifier.value = const RangeValues(0.0, 5.0);
    selectedFoodSubCateg.value = {};
    selectedBvgSubCateg.value = {};
  }

  void _confirmFilter(BuildContext context) {
    filterModel = FiltersModel(
      radiusMin: radiusNotifier.value.start,
      radiusMax: radiusNotifier.value.end,
      priceRangeMin: priceRangeNotifier.value.start,
      priceRangeMax: priceRangeNotifier.value.end,
      ratingMin: ratingNotifier.value.start,
      ratingMax: ratingNotifier.value.end,
      foodSubCateg: selectedFoodSubCateg.value.toList(),
      bvgSubCateg: selectedFoodSubCateg.value.toList(),
    );
    Navigator.pop(context, filterModel);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _fnbFiltersAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          // decoration: BoxDecoration(
          //   color: theme(context)
          //       .colorScheme
          //       .onSecondaryContainer
          //       .withOpacity(0.6),
          //   image: DecorationImage(
          //     image: AssetImage(ImageConstant.background2),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: _body(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _fnbFiltersAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.only(left: 5.h),
        child: IconButton(
          iconSize: 25.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          context.tr("filter.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 55.h),
      padding: EdgeInsets.all(10.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            FNBFiltersSlider(
              label: context.tr("filter.radius"),
              minLabel: context.tr("filter.radius_value", namedArgs: {
                "radius": radiusNotifier.value.start.ceil().toString()
              }),
              maxLabel: context.tr("filter.radius_value", namedArgs: {
                "radius": radiusNotifier.value.end.ceil().toString()
              }),
              rangeValuesNotifier: radiusNotifier,
              slideMinVal: 0.0,
              slideMaxVal: 100.0,
              division: 10,
              onChangeEnd: (value) {
                setState(() {
                  filterModel.radiusMin = value.start;
                  filterModel.radiusMax = value.end;
                });
              },
            ),
            SizedBox(height: 10.h),
            FNBFiltersSlider(
              label: context.tr("filter.price_range"),
              minLabel: context.tr("filter.price_range_value", namedArgs: {
                "price":
                    priceRangeNotifier.value.start.ceil().toString().length >= 3
                        ? (priceRangeNotifier.value.start / 1000)
                            .ceil()
                            .toString()
                        : priceRangeNotifier.value.start.ceil().toString(),
                "prefix":
                    priceRangeNotifier.value.start.ceil().toString().length >= 3
                        ? "K"
                        : ""
              }),
              maxLabel: context.tr("filter.price_range_value", namedArgs: {
                "price":
                    priceRangeNotifier.value.end.ceil().toString().length >= 3
                        ? (priceRangeNotifier.value.end / 1000)
                            .ceil()
                            .toString()
                        : priceRangeNotifier.value.end.ceil().toString(),
                "prefix":
                    priceRangeNotifier.value.end.ceil().toString().length >= 3
                        ? "K"
                        : ""
              }),
              rangeValuesNotifier: priceRangeNotifier,
              slideMinVal: 0.0,
              slideMaxVal: 1000000.0,
              division: 20,
              onChangeEnd: (value) {
                setState(() {
                  filterModel.priceRangeMin = value.start;
                  filterModel.priceRangeMin = value.end;
                });
              },
            ),
            SizedBox(height: 10.h),
            FNBFiltersSlider(
              label: context.tr("filter.rating"),
              minLabel: context.tr("filter.rating_min_value"),
              maxLabel: context.tr("filter.rating_max_value"),
              rangeValuesNotifier: ratingNotifier,
              slideMinVal: 0.0,
              slideMaxVal: 5.0,
              division: 5,
              onChangeEnd: (value) {
                setState(() {
                  filterModel.ratingMin = value.start;
                  filterModel.ratingMax = value.end;
                });
              },
            ),
            SizedBox(height: 10.h),
            _buildSubCateg(
              context,
              "filter.foods",
              foodsCateg,
              selectedFoodSubCateg,
            ),
            SizedBox(height: 10.h),
            _buildSubCateg(
              context,
              "filter.beverages",
              bvgsCateg,
              selectedBvgSubCateg,
            ),
            SizedBox(height: 25.h),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: _buildSubmitButton(
                          context, "filter.revert_btn", () => _resetValue())),
                  Flexible(
                      child: _buildSubmitButton(context, "filter.submit_btn",
                          () => _confirmFilter(context))),
                ],
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSubCateg(BuildContext context, String label,
      List<String> listFilter, ValueNotifier<Set<String>> selectedCateg) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: CustomDecoration(context).fillOnSecondaryContainer.copyWith(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr(label),
            useIcon: false,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.h),
            child: Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 10.h,
              spacing: 10.h,
              children: List<Widget>.generate(
                listFilter.length,
                (index) {
                  return FNBFiltersItem(
                    label: listFilter[index],
                    multiSelect: true,
                    multiSelectedChoices: selectedCateg,
                    isWrap: true,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(
      BuildContext context, String label, Function()? onPressed) {
    return SizedBox(
      height: 60.h,
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
      ),
    );
  }
}
