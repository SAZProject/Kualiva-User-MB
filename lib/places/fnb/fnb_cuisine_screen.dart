import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/dataset/f_n_b_dataset.dart';
import 'package:kualiva/common/dataset/f_n_b_filter_dataset.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/_data/model/f_n_b_model.dart';
import 'package:kualiva/_data/model/ui_model/filters_model.dart';
import 'package:kualiva/places/fnb/widget/fnb_filters_item.dart';
import 'package:kualiva/places/fnb/widget/fnb_place_item.dart';

class FnbCuisineScreen extends StatefulWidget {
  const FnbCuisineScreen({super.key, required this.cuisineTitle});

  final String cuisineTitle;

  @override
  State<FnbCuisineScreen> createState() => _FNBCuisineState();
}

class _FNBCuisineState extends State<FnbCuisineScreen> {
  final ScrollController _parentScrollController = ScrollController();
  final ScrollController _childScrollController = ScrollController();

  final List<FNBModel> featuredListItems = FNBDataset().featuredItemsDataset;

  final List<String> _listTagsFilter = FNBFilterDataset.fnbFoodFilter;
  ValueNotifier<Set<String>> selectedFilters = ValueNotifier<Set<String>>({});

  late FiltersModel filtersModel;

  @override
  void dispose() {
    _parentScrollController.dispose();
    _childScrollController.dispose();
    selectedFilters.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _cuisineAppBar(context),
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

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            _searchBar(context),
            SizedBox(height: 5.h),
            _tagsFilter(context),
            SizedBox(height: 5.h),
            _placeList(context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _cuisineAppBar(BuildContext context) {
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
          widget.cuisineTitle,
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
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
        Navigator.pushNamed(context, AppRoutes.fnbFilterScreen).then(
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

  Widget _placeList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      child: SizedBox(
        width: double.maxFinite,
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification) {
              if (notification.metrics.pixels ==
                  notification.metrics.maxScrollExtent) {
                _parentScrollController.animateTo(
                    _parentScrollController.position.maxScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeIn);
              } else if (notification.metrics.pixels ==
                  notification.metrics.minScrollExtent) {
                _parentScrollController.animateTo(
                    _parentScrollController.position.minScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeIn);
              }
            }
            return true;
          },
          child: featuredListItems.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: _childScrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: featuredListItems.length,
                  itemBuilder: (context, index) {
                    if (featuredListItems.isNotEmpty) {
                      return FnbPlaceItem(
                        fnbModel: featuredListItems[index],
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.fnbDetailScreen,
                            arguments: "placeId", // TODO
                          );
                        },
                      );
                    }
                    return const CustomEmptyState();
                  },
                ),
        ),
      ),
    );
  }
}
