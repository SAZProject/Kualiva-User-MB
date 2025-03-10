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

/// TODO: Winky UI nya gak sengaja keubah ccooyy, tapi dah Integrated well sama BE

class _MyFixedSearchBarWidgetState extends State<MyFixedSearchBarWidget> {
  final SearchController _searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: SearchAnchor(
        searchController: _searchController,
        isFullScreen: false,
        viewConstraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.4,
        ),
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        viewOnSubmitted: (value) {
          widget.onSubmitted(context, value);
          _searchController.closeView(value);
        },
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            // controller: controller,
            focusNode: FocusNode(),
            padding: WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.h),
            ),
            onTap: () {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder: widget.suggestionsBuilder,
      ),
    );
  }
}
