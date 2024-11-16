import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/home/model/home_ad_banner_model.dart';
import 'package:like_it/home/repository/promotion_repository.dart';

part 'home_ad_banner_event.dart';
part 'home_ad_banner_state.dart';

class HomeAdBannerBloc extends Bloc<HomeAdBannerEvent, HomeAdBannerState> {
  final PromotionRepository _promotionRepository;

  HomeAdBannerBloc(this._promotionRepository) : super(HomeAdBannerInitial()) {
    on<HomeAdBannerEvent>((event, emit) => emit(HomeAdBannerLoading()));
    on<HomeAdBannerFetched>(_onFetched);
  }

  void _onFetched(
    HomeAdBannerFetched event,
    Emitter<HomeAdBannerState> emit,
  ) async {
    try {
      final List<HomeAdBannerModel> adBanners =
          await _promotionRepository.getAdvertisementBanner();
      emit(HomeAdBannerSuccess(adBanners: adBanners));
    } catch (e) {
      emit(HomeAdBannerFailure());
    }
  }
}
