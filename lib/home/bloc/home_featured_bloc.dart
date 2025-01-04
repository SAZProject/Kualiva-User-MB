import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/home/model/home_featured_model.dart';
import 'package:kualiva/repository/promotion_repository.dart';

part 'home_featured_event.dart';
part 'home_featured_state.dart';

class HomeFeaturedBloc extends Bloc<HomeFeaturedEvent, HomeFeaturedState> {
  final PromotionRepository _promotionRepository;

  HomeFeaturedBloc(this._promotionRepository) : super(HomeFeaturedInitial()) {
    on<HomeFeaturedEvent>((event, emit) => emit(HomeFeaturedLoading()));

    on<HomeFeaturedFetched>(_onFetched);
  }

  void _onFetched(
    HomeFeaturedFetched event,
    Emitter<HomeFeaturedState> emit,
  ) async {
    try {
      final homeFeatured = await _promotionRepository.getFeatured();
      LeLog.bd(this, _onFetched, homeFeatured.toString());
      emit(HomeFeaturedSuccess(homeFeatured: homeFeatured));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(HomeFeaturedFailure());
    }
  }
}
