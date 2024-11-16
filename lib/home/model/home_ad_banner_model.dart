// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class HomeAdBannerModel {
  final String urlImage;
  final String? urlWeb;
  final String? placeId;

  const HomeAdBannerModel({
    required this.urlImage,
    this.urlWeb,
    this.placeId,
  });

  HomeAdBannerModel copyWith({
    String? urlImage,
    String? urlWeb,
    String? placeId,
  }) {
    return HomeAdBannerModel(
      urlImage: urlImage ?? this.urlImage,
      urlWeb: urlWeb ?? this.urlWeb,
      placeId: placeId ?? this.placeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'urlImage': urlImage,
      'urlWeb': urlWeb,
      'placeId': placeId,
    };
  }

  factory HomeAdBannerModel.fromMap(Map<String, dynamic> map) {
    return HomeAdBannerModel(
      urlImage: map['urlImage'] as String,
      urlWeb: map['urlWeb'] != null ? map['urlWeb'] as String : null,
      placeId: map['placeId'] != null ? map['placeId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeAdBannerModel.fromJson(String source) =>
      HomeAdBannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HomeAdBannerModel(urlImage: $urlImage, urlWeb: $urlWeb, placeId: $placeId)';

  @override
  bool operator ==(covariant HomeAdBannerModel other) {
    if (identical(this, other)) return true;

    return other.urlImage == urlImage &&
        other.urlWeb == urlWeb &&
        other.placeId == placeId;
  }

  @override
  int get hashCode => urlImage.hashCode ^ urlWeb.hashCode ^ placeId.hashCode;
}
