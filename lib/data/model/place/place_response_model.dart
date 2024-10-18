// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:like_it/data/model/place/place_model.dart';

@immutable
class PlaceResponseModel {
  final List<dynamic> htmlAttributions;
  final String nextPageToken;
  final List<Place> results;

  const PlaceResponseModel({
    required this.htmlAttributions,
    required this.nextPageToken,
    required this.results,
  });

  PlaceResponseModel copyWith({
    List<dynamic>? htmlAttributions,
    String? nextPageToken,
    List<Place>? results,
  }) {
    return PlaceResponseModel(
      htmlAttributions: htmlAttributions ?? this.htmlAttributions,
      nextPageToken: nextPageToken ?? this.nextPageToken,
      results: results ?? this.results,
    );
  }

  factory PlaceResponseModel.fromMap(Map<String, dynamic> map) {
    return PlaceResponseModel(
      htmlAttributions:
          List<dynamic>.from((map['html_attributions'] as List<dynamic>)),
      nextPageToken: map['next_page_token'] as String,
      results: (map['results'] as List<dynamic>)
          .map((result) => Place.fromJson(result))
          .toList(),
    );
  }

  factory PlaceResponseModel.fromJson(String source) =>
      PlaceResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PlaceResponseModel(htmlAttributions: $htmlAttributions, nextPageToken: $nextPageToken, results: $results)';

  @override
  bool operator ==(covariant PlaceResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.htmlAttributions, htmlAttributions) &&
        other.nextPageToken == nextPageToken &&
        listEquals(other.results, results);
  }

  @override
  int get hashCode =>
      htmlAttributions.hashCode ^ nextPageToken.hashCode ^ results.hashCode;
}
