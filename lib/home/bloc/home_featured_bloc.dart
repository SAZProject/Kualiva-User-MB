import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:like_it/home/model/home_featured_model.dart';
import 'package:like_it/home/repository/promotion_repository.dart';

part 'home_featured_event.dart';
part 'home_featured_state.dart';

class HomeFeaturedBloc extends Bloc<HomeFeaturedEvent, HomeFeaturedState> {
  final PromotionRepository _promotionRepository;

  HomeFeaturedBloc(this._promotionRepository) : super(HomeFeaturedInitial()) {
    on<HomeFeaturedEvent>((event, emit) => emit(HomeFeaturedLoading()));

    on<HomeFeaturedFethed>(_onFecthed);
  }

  void _onFecthed(
    HomeFeaturedFethed event,
    Emitter<HomeFeaturedState> emit,
  ) async {
    try {
      final homeFeatured = await _promotionRepository.getFeatured();

      emit(HomeFeaturedSuccess(homeFeatured: homeFeatured));
    } catch (e) {
      emit(HomeFeaturedFailure());
    }
  }
}
