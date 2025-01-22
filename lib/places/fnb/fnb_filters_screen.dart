import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/f_n_b_filter_dataset.dart';
import 'package:kualiva/common/widget/custom_gradient_outlined_button.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/_data/model/ui_model/filters_model.dart';
import 'package:kualiva/places/fnb/model/fnb_filter_toggle_model.dart';
import 'package:kualiva/places/fnb/widget/fnb_filters_grid_facilities.dart';
import 'package:kualiva/places/fnb/widget/fnb_filters_item.dart';
import 'package:kualiva/places/fnb/widget/fnb_filters_price_range.dart';
import 'package:kualiva/places/fnb/widget/fnb_filters_rating.dart';

class FnbFiltersScreen extends StatefulWidget {
  const FnbFiltersScreen({super.key, this.getFilterModel});

  final FiltersModel? getFilterModel;

  @override
  State<FnbFiltersScreen> createState() => _FNBFiltersScreenState();
}

class _FNBFiltersScreenState extends State<FnbFiltersScreen> {
  List<FnbFilterToggleModel> facilitesDataset =
      FNBFilterDataset.facilitiesDataset;
  List<FnbFilterToggleModel> categoriesDataset =
      FNBFilterDataset.categoriesDataset;

  FiltersModel filterModel = FiltersModel(
    rating: 0.0,
    priceRange: "",
    facilities: [],
    categories: [],
  );

  late ValueNotifier<double> ratingNotifier;
  late ValueNotifier<String> priceRangeNotifier;

  ValueNotifier<Set<String>> selectedFacilities =
      ValueNotifier<Set<String>>({"Open Now"});
  ValueNotifier<Set<String>> selectedCategories =
      ValueNotifier<Set<String>>({});

  @override
  void initState() {
    super.initState();
    if (widget.getFilterModel != null) {
      filterModel = widget.getFilterModel!;
    }
    ratingNotifier = ValueNotifier<double>(filterModel.rating);
    priceRangeNotifier = ValueNotifier<String>(filterModel.priceRange);
  }

  @override
  void dispose() {
    ratingNotifier.dispose();
    priceRangeNotifier.dispose();
    selectedFacilities.dispose();
    selectedCategories.dispose();
    super.dispose();
  }

  void _resetValue() {
    setState(() {
      ratingNotifier.value = 0.0;
      priceRangeNotifier.value = "";
      selectedFacilities.value = {"Open Now"};
      selectedCategories.value = {};
    });
  }

  void _confirmFilter(BuildContext context) {
    filterModel = FiltersModel(
      rating: ratingNotifier.value,
      priceRange: priceRangeNotifier.value,
      facilities: selectedFacilities.value.toList(),
      categories: selectedCategories.value.toList(),
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
          //       .withValues(0.6),
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
            FnbFiltersRating(
              label: context.tr("filter.rating"),
              ratingStar: ratingNotifier.value,
              onRatingUpdate: (value) => ratingNotifier.value = value,
            ),
            SizedBox(height: 10.h),
            ValueListenableBuilder(
              valueListenable: priceRangeNotifier,
              builder: (context, value, child) {
                return FnbFiltersPriceRange(
                  label: context.tr("filter.price_range"),
                  selectedPrice: priceRangeNotifier.value,
                  onChange: (value) => priceRangeNotifier.value = value,
                );
              },
            ),
            SizedBox(height: 10.h),
            FnbFiltersGridFacilities(
              label: context.tr("filter.facilities"),
              facilitiesDataset: facilitesDataset,
              selectedFacilities: selectedFacilities,
            ),
            SizedBox(height: 10.h),
            _buildSubCateg(
              context,
              "filter.categories",
              categoriesDataset,
              selectedCategories,
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

  Widget _buildSubCateg(
      BuildContext context,
      String label,
      List<FnbFilterToggleModel> listFilter,
      ValueNotifier<Set<String>> selectedCateg) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: CustomDecoration(context).fillOnSecondaryContainer.copyWith(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withValues(alpha: 0.6),
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
                  return FnbFiltersItem(
                    label: listFilter[index].label,
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
        onPressed: onPressed,
      ),
    );
  }
}
