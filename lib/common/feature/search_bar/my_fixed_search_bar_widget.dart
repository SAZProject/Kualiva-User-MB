import 'package:flutter/material.dart';
import 'package:kualiva/common/utility/sized_utils.dart';

class MyFixedSearchBarWidget extends StatelessWidget {
  const MyFixedSearchBarWidget({
    super.key,
    required this.viewOnSubmitted,
    required this.suggestionsBuilder,
  });

  final void Function(BuildContext, String) viewOnSubmitted;

  final Future<List<Widget>> Function(
    BuildContext context,
    SearchController searchController,
  ) suggestionsBuilder;

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
        viewOnSubmitted: (value) => viewOnSubmitted(context, value),
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
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
        suggestionsBuilder: suggestionsBuilder,
      ),
    );
  }
}
