import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/dataset/f_n_b_dataset.dart';
import 'package:like_it/common/widget/custom_location_dropdown.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/common/widget/sliver_app_bar_delegate.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/ui_model/loc_dropdown_model.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_nearest_item.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_promo_item.dart';

class FNBScreen extends StatefulWidget {
  const FNBScreen({super.key});

  @override
  State<FNBScreen> createState() => _FNBScreenState();
}

class _FNBScreenState extends State<FNBScreen> {
  final List<LocDropdownModel> _dummyLoc = [
    LocDropdownModel(id: "0", subdistrict: "Tanah Abang", city: "Bekasi"),
    LocDropdownModel(
        id: "1", subdistrict: "Pondok Gede", city: "Jakarta Pusat"),
  ];

  final List<FNBModel> featuredListItems = FNBDataset().featuredItemsDataset;

  final List<String> _listTagsFilter = [
    "Beverages",
    "All You Can Eat",
    "Chinese Dish",
    "Japanese Dish",
    "Indian Dish",
    "Seafood",
    "Dine In",
    "Buffet",
    "Vegetarian",
    "Cafe",
    "Cocktail",
    "Coffee",
    "Tea",
    "European Dish",
    "Asian Dish",
    "Fast Food",
    "Drive Thru",
    "Takeaway",
    "Italian Food",
    "Local Food",
    "Warteg",
  ];

  final List<String> _dummyImageData = [
    "${ImageConstant.fnb1Path}/A/2.jpg",
    "${ImageConstant.fnb2Path}/A/2.jpg",
    "${ImageConstant.fnb3Path}/A/2.jpg",
    "${ImageConstant.fnb4Path}/A/2.jpg",
    "${ImageConstant.fnb5Path}/A/2.jpg",
  ];

  final List<DropdownMenuItem<LocDropdownModel>> _locationsItem = [];

  LocDropdownModel? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: theme(context).scaffoldBackgroundColor,
                image: DecorationImage(
                  image: AssetImage(ImageConstant.background2),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: _body(context),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _homeAppBar(context),
            _searchBar(context),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _tagsFilter(context),
              SizedBox(height: 5.h),
              _nearestList(context),
              SizedBox(height: 5.h),
              _promoList(context),
              SizedBox(height: 5.h),
              _chefChoices(context),
              SizedBox(height: 5.h),
              _bestRated(context),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      automaticallyImplyLeading: true,
      pinned: false,
      snap: false,
      floating: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr("common.current_location"),
            style: CustomTextStyles(context).titleLargeBlack900W400_22,
          ),
          _locationFilterDropdown(context),
        ],
      ),
      toolbarHeight: 100.h,
    );
  }

  Widget _locationFilterDropdown(BuildContext context) {
    return FutureBuilder<List<DropdownMenuItem<LocDropdownModel>>>(
      future: Future<List<DropdownMenuItem<LocDropdownModel>>>(
        () {
          _locationsItem.clear();
          _locationsItem.addAll(_dummyLoc.map(
            (locationModel) {
              return dataDropdownItem(context, locationModel,
                  "${locationModel.subdistrict}, ${locationModel.city}");
            },
          ));
          return _locationsItem;
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorDropdownItem(context);
        }
        if (snapshot.hasData) {
          return filterDropdownButton(
            context,
            _selectedLocation,
            _locationsItem,
            (value) {
              setState(() {
                _selectedLocation = value;
              });
            },
          );
        }
        return loadingDropdownItem(context);
      },
    );
  }

  Widget _searchBar(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                focusNode: FocusNode(),
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                onSubmitted: (value) {
                  setState(() {
                    controller.closeView(value);
                  });
                },
                onTapOutside: (event) {
                  FocusScopeNode focusNode = FocusScope.of(context);
                  if (focusNode.hasPrimaryFocus) {
                    focusNode.unfocus();
                  }
                },
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(
                5,
                (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                },
              );
            },
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
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _tagView(
                context,
                icon: Center(
                  child: Icon(
                    Icons.filter_alt,
                    size: 20.h,
                  ),
                ),
              );
            }
            return _tagView(context, label: _listTagsFilter[index - 1]);
          },
        ),
      ),
    );
  }

  Widget _tagView(BuildContext context, {String? label, Widget? icon}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.h),
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        decoration: CustomDecoration(context).fillPrimary.copyWith(
              borderRadius: icon != null
                  ? BorderRadius.circular(50.0)
                  : BorderRadiusStyle.roundedBorder5,
            ),
        child: Center(
          child: icon ??
              Text(
                label!,
                textAlign: TextAlign.center,
                style: CustomTextStyles(context).bodyMedium_13,
              ),
        ),
      ),
    );
  }

  Widget _nearestList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.nearest"),
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            height: 450.h,
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) {
                return SizedBox(width: 14.h);
              },
              itemCount: 6,
              itemBuilder: (context, index) {
                return FNBNearestItem(
                  fnbModel: featuredListItems[index],
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.fnbDetailScreen,
                        arguments: featuredListItems[index]);
                  },
                );
              },
            ),
          ),
        ],
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
            onPressed: () {},
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            height: 200.h,
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(width: 14.h);
              },
              itemCount: 6,
              itemBuilder: (context, index) {
                return FNBPromoItem(
                  fnbModel: featuredListItems[index],
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.fnbDetailScreen,
                        arguments: featuredListItems[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _chefChoices(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.chef_choice"),
            onPressed: () {},
          ),
          Container(
            height: 150.h,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: _dummyImageData.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 8.h),
                  child: CustomImageView(
                    imagePath: _dummyImageData[index],
                    height: 130.h,
                    width: 200.h,
                    radius: BorderRadius.circular(10.h),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bestRated(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.best_rated"),
            onPressed: () {},
          ),
          Container(
            height: 150.h,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: _dummyImageData.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 8.h),
                  child: CustomImageView(
                    imagePath: _dummyImageData[index],
                    height: 130.h,
                    width: 200.h,
                    radius: BorderRadius.circular(10.h),
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
