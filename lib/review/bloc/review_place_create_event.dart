part of 'review_place_create_bloc.dart';

@immutable
sealed class ReviewPlaceCreateEvent {}

final class ReviewPlaceCreateStarted extends ReviewPlaceCreateEvent {}

final class ReviewPlaceCreate extends ReviewPlaceCreateEvent {
  final String placeId;
  final String placeCategory;
  final String invoice;
  final String description;
  final String invoiceFile;
  final int rating;
  final List<String> photoFiles;

  ReviewPlaceCreate({
    required this.placeId,
    required this.placeCategory,
    required this.invoice,
    required this.description,
    required this.invoiceFile,
    required this.rating,
    required this.photoFiles,
  });
}

final class ReviewPlaceCreateRefreshed extends ReviewPlaceCreateEvent {
  final String placeId;
  final String placeCategory;
  final String invoice;
  final String description;
  final String invoiceFile;
  final int rating;
  final List<String> photoFiles;

  ReviewPlaceCreateRefreshed({
    required this.placeId,
    required this.placeCategory,
    required this.invoice,
    required this.description,
    required this.invoiceFile,
    required this.rating,
    required this.photoFiles,
  });
}
