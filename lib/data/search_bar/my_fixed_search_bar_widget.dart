import 'package:flutter/material.dart';
import 'package:like_it/common/utility/sized_utils.dart';

class MyFixedSearchBarWidget extends StatelessWidget {
  const MyFixedSearchBarWidget({
    super.key,
    required this.suggestionsBuilder,
  });

  final Future<List<Widget>> Function(
    BuildContext context,
    SearchController searchController,
  ) suggestionsBuilder;

  @override
  Widget build(BuildContext context) {
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
              controller.closeView(value);
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
        suggestionsBuilder: suggestionsBuilder,
      ),
    );
  }
}
