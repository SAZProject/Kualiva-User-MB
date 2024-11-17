part of 'home_featured_bloc.dart';

@immutable
sealed class HomeFeaturedState {}

final class HomeFeaturedInitial extends HomeFeaturedState {}

final class HomeFeaturedLoading extends HomeFeaturedState {}

final class HomeFeaturedSuccess extends HomeFeaturedState {
  final List<HomeFeaturedModel> homeFeatured;

  HomeFeaturedSuccess({required this.homeFeatured});
}

final class HomeFeaturedFailure extends HomeFeaturedState {}
