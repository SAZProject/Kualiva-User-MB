import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/data/model/ui_model/collection_model.dart';

class SaveToCollection extends StatefulWidget {
  const SaveToCollection({super.key});

  @override
  State<SaveToCollection> createState() => _SaveToCollectionState();
}

class _SaveToCollectionState extends State<SaveToCollection> {
  final List<CollectionModel> _listCollection = [
    CollectionModel(
      id: "0",
      thumbnail: "",
      label: "save_to_collection.all",
      content: "save_to_collection.total_places",
    ),
    CollectionModel(
      id: "1",
      thumbnail: "",
      label: "Collection Name 1",
      content: "save_to_collection.total_places",
    ),
    CollectionModel(
      id: "2",
      thumbnail: "",
      label: "Collection Name 2",
      content: "save_to_collection.total_places",
    ),
    CollectionModel(
      id: "3",
      thumbnail: "",
      label: "Collection Name 3",
      content: "save_to_collection.total_places",
    ),
  ];

  String selectedCollection = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.maxFinite,
          height: Sizeutils.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.5, 0),
              end: const Alignment(0.5, 1),
              colors: [
                appTheme.yellowA700.withOpacity(0.3),
                theme(context).colorScheme.primary.withOpacity(0.3),
              ],
            ),
          ),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _saveCollectionAppBar(context),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              _savedCollectionList(context),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _saveCollectionAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(10.h),
        child: IconButton(
          iconSize: 40.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          context.tr("save_to_collection.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _savedCollectionList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
              label: context.tr("save_to_collection.add_to_collection")),
          SizedBox(height: 4.h),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) {
                return SizedBox(width: 10.h);
              },
              itemCount: _listCollection.length,
              itemBuilder: (context, index) {
                return _savedCollectionListItem(
                  context,
                  index,
                  _listCollection[index].label,
                  _listCollection[index].content,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _savedCollectionListItem(
      BuildContext context, int index, String label, String content) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          Container(
            height: 80.h,
            width: 80.h,
            decoration: BoxDecoration(
              color: appTheme.gray500,
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 10.h),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
            width: 20.h,
            child: Radio<String>(
              visualDensity: const VisualDensity(
                vertical: -4,
                horizontal: -4,
              ),
              value: index.toString(),
              groupValue: selectedCollection,
              onChanged: (value) {
                selectedCollection = value!;
              },
            ),
          )
        ],
      ),
    );
  }
}
