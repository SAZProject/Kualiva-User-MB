import 'package:flutter/material.dart';

// TODO: Nanti di hapus
// INi cuma coba-coba aja copas dari google

class SearchBarApalah extends StatefulWidget {
  const SearchBarApalah({super.key});

  @override
  State<SearchBarApalah> createState() => _SearchBarApalahState();
}

class _SearchBarApalahState extends State<SearchBarApalah> {
  final SearchController _searchController = SearchController();
  final List<String> _suggestions = [
    "Apple",
    "Banana",
    "Orange",
    "Mango",
    "Grapes"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchAnchor(
        isFullScreen: false,
        viewConstraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.4,
        ),
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        searchController: _searchController,
        builder: (context, controller) {
          return SearchBar(
            controller: controller,
            hintText: "Search fruits...",
            leading: const Icon(Icons.search),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onTap: () {
              controller.openView();
            },
            onChanged: (value) {
              controller.openView(); // Open suggestions when typing
              print("DRucco");
              print("onChanged: $value");
            },
            onSubmitted: (value) {
              controller.closeView(value); // Close and use value
              print("DRucco");
              print("onSubmitted: $value");
            },
          );
        },
        suggestionsBuilder: (context, controller) {
          return _suggestions
              .where((item) =>
                  item.toLowerCase().contains(controller.text.toLowerCase()))
              .map((suggestion) {
            return ListTile(
              title: Text(suggestion),
              onTap: () {
                controller.closeView(suggestion);
                print("DRucco");
                print("Selected: $suggestion");
              },
            );
          }).toList();
        },
      ),
    );
  }
}
