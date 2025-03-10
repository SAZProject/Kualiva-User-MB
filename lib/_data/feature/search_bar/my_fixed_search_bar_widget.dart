import 'package:flutter/material.dart';
import 'package:kualiva/common/utility/sized_utils.dart';

class MyFixedSearchBarWidget extends StatefulWidget {
  const MyFixedSearchBarWidget({
    super.key,
    required this.suggestionsBuilder,
    required this.onSubmitted,
  });

  final void Function(BuildContext, String) onSubmitted;

  final Future<List<Widget>> Function(
    BuildContext context,
    SearchController searchController,
  ) suggestionsBuilder;

  @override
  State<MyFixedSearchBarWidget> createState() => _MyFixedSearchBarWidgetState();
}

class _MyFixedSearchBarWidgetState extends State<MyFixedSearchBarWidget> {
  final searchTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchTextEditingController.addListener(() {
      print("DRucco");
      print("searchTextEditingController.addListener");
      print(searchTextEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: SearchAnchor(
        isFullScreen: false,
        viewConstraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.4,
        ),
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: searchTextEditingController,
            // controller: controller,
            focusNode: FocusNode(),
            padding: WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.h),
            ),
            onTap: () {
              controller.openView();
            },
            onChanged: (value) {
              print("DRucco");
              print("onChanged: $value");
              print("onChanged: ${controller.text}");
              widget.onSubmitted(context, controller.text);
              // controller.openView();
            },
            // onSubmitted: (value) {
            //   print("DRucco");
            //   print("onSubmitted: $value");
            //   controller.closeView(value);
            //   widget.onSubmitted(context, value);
            // },
            // onTapOutside: (event) {
            //   print("DRucco");
            //   print('onTapOutside');
            //   FocusScope.of(context).unfocus();
            // },
            // leading: const Icon(Icons.search),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            leading: IconButton(
              onPressed: controller.clear,
              icon: const Icon(Icons.close),
            ),
            trailing: <Widget>[
              IconButton(
                onPressed: controller.openView,
                icon: const Icon(Icons.search),
              ),
            ],
          );
        },
        suggestionsBuilder: widget.suggestionsBuilder,
      ),
    );
  }
}
