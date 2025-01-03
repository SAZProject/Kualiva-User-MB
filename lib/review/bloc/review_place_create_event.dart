part of 'review_place_create_bloc.dart';

@immutable
sealed class ReviewPlaceCreateEvent {}

final class ReviewPlaceTempCreated extends ReviewPlaceCreateEvent {
  final String placeUniqueId;
  final PlaceCategoryEnum placeCategory;
  final String invoice;
  final String invoiceFile;

  ReviewPlaceTempCreated({
    required this.placeUniqueId,
    required this.placeCategory,
    required this.invoice,
    required this.invoiceFile,
  });
}

final class ReviewPlaceCreated extends ReviewPlaceCreateEvent {
  final String description;
  final double rating;
  final List<String> photoFiles;

  ReviewPlaceCreated({
    required this.description,
    required this.rating,
    required this.photoFiles,
  });
}
