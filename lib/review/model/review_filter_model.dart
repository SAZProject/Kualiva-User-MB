import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:kualiva/review/enum/review_order_enum.dart';
import 'package:kualiva/review/enum/review_selected_user_enum.dart';

part 'review_filter_model.g.dart';

@immutable
@HiveType(typeId: 13)
class ReviewFilterModel {
  @HiveField(0)
  final String? description;

  @HiveField(1)
  final ReviewSelectedUserEnum? selectedUser;

  @HiveField(2)
  final bool? withMedia;

  @HiveField(3)
  final int? rating;

  @HiveField(4)
  final ReviewOrderEnum? order;

  const ReviewFilterModel({
    this.description,
    this.selectedUser,
    this.withMedia,
    this.rating,
    this.order,
  });

  ReviewFilterModel copyWith({
    ValueGetter<String?>? description,
    ValueGetter<ReviewSelectedUserEnum?>? selectedUser,
    ValueGetter<bool?>? withMedia,
    ValueGetter<int?>? rating,
    ValueGetter<ReviewOrderEnum?>? order,
  }) {
    return ReviewFilterModel(
      description: description != null ? description() : this.description,
      selectedUser: selectedUser != null ? selectedUser() : this.selectedUser,
      withMedia: withMedia != null ? withMedia() : this.withMedia,
      rating: rating != null ? rating() : this.rating,
      order: order != null ? order() : this.order,
    );
  }

  @override
  String toString() {
    return 'ReviewFilterModel(description: $description, selectedUser: $selectedUser, withMedia: $withMedia, rating: $rating, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewFilterModel &&
        other.description == description &&
        other.selectedUser == selectedUser &&
        other.withMedia == withMedia &&
        other.rating == rating &&
        other.order == order;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        selectedUser.hashCode ^
        withMedia.hashCode ^
        rating.hashCode ^
        order.hashCode;
  }
}
