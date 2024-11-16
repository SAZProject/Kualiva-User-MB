part of 'home_ad_banner_bloc.dart';

@immutable
sealed class HomeAdBannerState {}

final class HomeAdBannerInitial extends HomeAdBannerState {}

final class HomeAdBannerLoading extends HomeAdBannerState {}

final class HomeAdBannerSuccess extends HomeAdBannerState {
  final List<HomeAdBannerModel> adBanners;

  HomeAdBannerSuccess({
    required this.adBanners,
  });
}

final class HomeAdBannerFailure extends HomeAdBannerState {}
