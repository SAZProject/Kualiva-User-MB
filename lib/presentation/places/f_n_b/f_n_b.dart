import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/dataset/f_n_b_dataset.dart';
import 'package:like_it/common/dataset/f_n_b_filter_dataset.dart';
import 'package:like_it/common/utility/location_utility.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/common/widget/custom_selectable_staggered_grid.dart';
import 'package:like_it/common/widget/sliver_app_bar_delegate.dart';
import 'package:like_it/data/model/f_n_b_model.dart';
import 'package:like_it/data/model/ui_model/f_n_b_asset_model.dart';
import 'package:like_it/data/model/ui_model/filters_model.dart';
import 'package:like_it/data/model/util_model/user_curr_loc_model.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_filters_item.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_place_item.dart';
import 'package:like_it/presentation/places/f_n_b/widget/f_n_b_promo_item.dart';
import 'package:like_it/app_routes.dart';

class FNBScreen extends StatefulWidget {
  const FNBScreen({super.key});

  @override
  State<FNBScreen> createState() => _FNBScreenState();
}

class _FNBScreenState extends State<FNBScreen> {
  final ScrollController _parentScrollController = ScrollController();
  final ScrollController _childScrollController = ScrollController();
  final ScrollController _childScrollController2 = ScrollController();

  bool _locIsInitialized = false;

  // final List<LocDropdownModel> _dummyLoc = [
  //   LocDropdownModel(
  //     id: "0",
  //     subdistrict: "Tanah Abang",
  //     city: "Jakarta Pusat",
  //     latitude: "-6.186486",
  //     longitude: "106.834091",
  //   ),
  //   LocDropdownModel(
  //     id: "1",
  //     subdistrict: "Pondok Gede",
  //     city: "Bekasi",
  //     latitude: "-6.241586",
  //     longitude: "106.992416",
  //   ),
  // ];

  final List<FNBModel> featuredListItems = FNBDataset().featuredItemsDataset;

  final List<String> _listTagsFilter = FNBFilterDataset.fnbFoodFilter;

  ValueNotifier<Set<String>> selectedFilters = ValueNotifier<Set<String>>({});
  FiltersModel? filtersModel;

  final FNBAssetModel _dummyCuisineData = FNBDataset.cuisineDataset;
  Set<int> dummySelectedCuisine = {};

  late UserCurrLocModel getUserCurrentLoc;

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
    return SafeArea(
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
              _cuisine(context),
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
            style: CustomTextStyles(context).titleLargeOnPrimaryContainer,
          ),
          _currentUserLocation(context),
        ],
      ),
      toolbarHeight: 100.h,
    );
  }

  Widget _currentUserLocation(BuildContext context) {
    return FutureBuilder<UserCurrLocModel>(
      future: Future<UserCurrLocModel>(
        () async {
          if (!context.mounted) return Future.error("No context mounted");
          if (_locIsInitialized == false) {
            //TODO after user go to open setting and allow permission, refresh page to get user loc
            if (await LocationUtility.checkPermission(context)) {
              try {
                final res = await LocationUtility.getUserCurrLoc();
                setState(() {
                  getUserCurrentLoc = res;
                  _locIsInitialized = true;
                });
              } catch (e) {
                return Future.error(e);
              }
            } else {
              return Future.error("No Connection or error on locator");
            }
          }
          return getUserCurrentLoc;
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildUserLoc(context, context.tr("common.error"));
        }
        if (snapshot.hasData) {
          return _buildUserLoc(context,
              "${getUserCurrentLoc.userCurrSubDistrict}, ${getUserCurrentLoc.userCurrCity}");
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildUserLoc(BuildContext context, String label) {
    return InkWell(
      // TODO dimatikan untuk V1
      // onTap: () {
      //   Navigator.pushNamed(context, AppRoutes.locationScreen);
      // },
      child: SizedBox(
        width: double.maxFinite,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.h,
        maxHeight: 60.h,
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                focusNode: FocusNode(),
                padding: WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.h)),
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
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //TODO add waiting, empty, error state in future
            if (index == 0) return _filterScreenBtn(context, index, label: "");
            if ((index - 1) == 0) {
              return FNBFiltersItem(
                label: _listTagsFilter[index - 1],
                isWrap: false,
                multiSelect: true,
                isExecutive: true,
                multiSelectedChoices: selectedFilters,
              );
            }
            return FNBFiltersItem(
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
              debugPrint(filtersModel.toString());
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

  Widget _nearestList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("f_n_b.nearest"),
            // onPressed: () {},
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.h),
            child: SizedBox(
              height: 450.h,
              width: double.maxFinite,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification) {
                    if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                      debugPrint('Reached the bottom');
                      _parentScrollController.animateTo(
                          _parentScrollController.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    } else if (notification.metrics.pixels ==
                        notification.metrics.minScrollExtent) {
                      debugPrint('Reached the top');
                      _parentScrollController.animateTo(
                          _parentScrollController.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                  controller: _childScrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    //TODO add waiting, empty, error state in future
                    return FNBPlaceItem(
                      fnbModel: featuredListItems[index],
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.fnbDetailScreen,
                            arguments: featuredListItems[index]);
                      },
                    );
                  },
                ),
              ),
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
                  //TODO add waiting, empty, error state in future
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
          ),
        ],
      ),
    );
  }

  Widget _cuisine(BuildContext context) {
    var brightness = Theme.of(context).brightness;
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
            label: context.tr("f_n_b.cuisine"),
            useIcon: false,
          ),
          Container(
            height: 350.h,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            width: double.maxFinite,
            child: NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    debugPrint('Reached the bottom');
                    if (_parentScrollController.position.atEdge) return true;
                    _parentScrollController.animateTo(
                        _parentScrollController.position.minScrollExtent,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn);
                  } else if (notification.metrics.pixels ==
                      notification.metrics.minScrollExtent) {
                    debugPrint('Reached the top');
                    _parentScrollController.animateTo(
                        _parentScrollController.position.minScrollExtent,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn);
                  }
                }
                return true;
              },
              // Navigator.pushNamed(context, AppRoutes.fnbCuisineScreen);
              child: CustomSelectableStaggeredGrid(
                controller: _childScrollController2,
                totalItem: _dummyCuisineData.totalItem,
                bgImages: _dummyCuisineData.listAssetBg ?? [],
                iconImages: brightness == Brightness.light
                    ? _dummyCuisineData.listAssetLight
                    : _dummyCuisineData.listAssetDark,
                labels: _dummyCuisineData.listTitle,
                isEmpty: _dummyCuisineData.listTitle.isEmpty,
                onSelected: (index) {
                  Navigator.pushNamed(context, AppRoutes.fnbCuisineScreen,
                      arguments: _dummyCuisineData.listTitle[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
