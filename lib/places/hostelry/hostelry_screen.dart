import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/f_n_b_dataset.dart';
import 'package:kualiva/common/dataset/filter_dataset.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/_data/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/_data/model/f_n_b_model.dart';
import 'package:kualiva/_data/model/ui_model/filters_model.dart';
import 'package:kualiva/places/fnb/feature/fnb_app_bar_feature.dart';
import 'package:kualiva/places/fnb/feature/fnb_search_bar_feature.dart';
import 'package:kualiva/places/fnb/widget/fnb_filters_item.dart';
import 'package:kualiva/places/fnb/widget/fnb_promo_item.dart';
import 'package:kualiva/places/hostelry/bloc/hotel_nearest_bloc.dart';
import 'package:kualiva/places/hostelry/feature/hotel_nearest_feature.dart';

class HostelryScreen extends StatefulWidget {
  const HostelryScreen({super.key});

  @override
  State<HostelryScreen> createState() => _HostelryScreenState();
}

class _HostelryScreenState extends State<HostelryScreen> {
  final _parentScrollController = ScrollController();
  final _childScrollController = ScrollController();
  final _childScrollController2 = ScrollController();

  final List<FNBModel> featuredListItems = FNBDataset().featuredItemsDataset;

  final List<String> _listTagsFilter = FilterDataset.fnbFoodFilter;

  ValueNotifier<Set<String>> selectedFilters = ValueNotifier<Set<String>>({});
  FiltersModel? filtersModel;

  Set<int> dummySelectedCuisine = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _parentScrollController.dispose();
    _childScrollController.dispose();
    _childScrollController2.dispose();
    selectedFilters.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, state) {
        // context
        //     .read<HotelNearestBloc>()
        //     .add(HotelNearestFetched(latitude: 0.0, longitude: 0.0));
        if (state is! CurrentLocationSuccess) return;

        context.read<HotelNearestBloc>().add(HotelNearestFetched(
              latitude: state.currentLocationModel.latitude,
              longitude: state.currentLocationModel.longitude,
            ));
      },
      child: SafeArea(
        child: Stack(
          children: [
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: Container(
            //     width: double.maxFinite,
            //     decoration: BoxDecoration(
            //       color: theme(context).scaffoldBackgroundColor,
            //       image: DecorationImage(
            //         image: AssetImage(ImageConstant.background2),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
            Scaffold(
              // backgroundColor: Colors.transparent,
              body: _body(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: NestedScrollView(
        controller: _parentScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            FnbAppBarFeature(),
            FnbSearchBarFeature(),
            // _searchBar(context),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _tagsFilter(context),
              SizedBox(height: 5.h),
              // _nearestList(context),
              HotelNearestFeature(
                parentContext: context,
                parentScrollController: _parentScrollController,
                childScrollController: _childScrollController,
              ),
              SizedBox(height: 5.h),
              _promoList(context),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tagsFilter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: SizedBox(
        height: 30.h,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: _listTagsFilter.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //TODO add waiting, empty, error state in future
            if (index == 0) return _filterScreenBtn(context, index, label: "");
            if ((index - 1) == 0) {
              return FnbFiltersItem(
                label: _listTagsFilter[index - 1],
                isWrap: false,
                multiSelect: true,
                isExecutive: true,
                multiSelectedChoices: selectedFilters,
              );
            }
            return FnbFiltersItem(
              label: _listTagsFilter[index - 1],
              isWrap: false,
              multiSelect: true,
              multiSelectedChoices: selectedFilters,
            );
          },
        ),
      ),
    );
  }

  Widget _filterScreenBtn(BuildContext context, int index, {String? label}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.h),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.fnbFilterScreen,
                arguments: filtersModel)
            .then(
          (value) {
            if (value == null) return;
            setState(() {
              filtersModel = value as FiltersModel;
            });
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        decoration: CustomDecoration(context).fillPrimary.copyWith(
              borderRadius: BorderRadius.circular(50.h),
            ),
        child: Center(
          child: Center(
            child: Icon(
              Icons.filter_alt,
              size: 20.h,
            ),
          ),
        ),
      ),
    );
  }

  Widget _promoList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.promo"),
            // TODO dimatikan untuk V1
            // onPressed: () {
            // },
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              height: 225.h,
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  // TODO: Not yet
                  // return FnbPromoItem(
                  //   fnbModel: featuredListItems[index],
                  //   onPressed: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       AppRoutes.fnbDetailScreen,
                  //       arguments: "placeId", // TODO
                  //     );
                  //   },
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
