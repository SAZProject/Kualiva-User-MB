import 'package:flutter/material.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/feature/search_bar/my_sliver_app_bar_delegate.dart';

class MySliverSearchBarWidget extends StatelessWidget {
  const MySliverSearchBarWidget({
    super.key,
    this.viewOnSubmitted,
    required this.suggestionsBuilder,
  });

  final Function(String)? viewOnSubmitted;

  final Future<List<Widget>> Function(
    BuildContext context,
    SearchController searchController,
  ) suggestionsBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: MySliverAppBarDelegate(
        minHeight: 60.h,
        maxHeight: 60.h,
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: SearchAnchor(
            viewOnSubmitted: viewOnSubmitted,
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                focusNode: FocusNode(),
                padding: WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.h)),
                onTap: () {
                  controller.openView();
                },
                onChanged: (value) {
                  controller.openView();
                  debugPrint("onChanged");
                  debugPrint(value);
                },
                onSubmitted: (value) {
                  controller.closeView(value);
                  debugPrint("onSubmitted");
                  debugPrint(value);
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
        ),
      ),
    );
  }
}
