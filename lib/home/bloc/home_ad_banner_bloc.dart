import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/home/model/home_ad_banner_model.dart';
import 'package:kualiva/_repository/promotion/promotion_repository.dart';

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
      LeLog.bd(this, _onFetched, adBanners.toString());
      emit(HomeAdBannerSuccess(adBanners: adBanners));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(HomeAdBannerFailure());
    }
  }
}
