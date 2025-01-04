import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_empty_state.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/_data/model/ui_model/collection_model.dart';

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
        extendBodyBehindAppBar: true,
        appBar: _saveCollectionAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: const Alignment(0.5, 0),
          //     end: const Alignment(0.5, 1),
          //     colors: [
          //       appTheme.yellowA700,
          //       theme(context).colorScheme.primary,
          //     ],
          //   ),
          // ),
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
      automaticallyImplyLeading: false,
      centerTitle: true,
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
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: context.tr("save_to_collection.add_to_collection"),
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          _listCollection.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _listCollection.length,
                  itemBuilder: (context, index) {
                    if (_listCollection.isNotEmpty) {
                      return _savedCollectionListItem(
                        context,
                        index,
                        _listCollection[index].label,
                        _listCollection[index].content,
                      );
                    }
                    return const CustomEmptyState();
                  },
                ),
        ],
      ),
    );
  }

  Widget _savedCollectionListItem(
      BuildContext context, int index, String label, String content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
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
                  index == 0 ? context.tr(label) : label,
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 10.h),
                Text(
                  context.tr(content, namedArgs: {"index": "$index"}),
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
