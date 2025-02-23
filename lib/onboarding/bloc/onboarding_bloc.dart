import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_repository/onboarding_repository.dart';
import 'package:kualiva/common/utility/lelog.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository _onboardingRepository;

  OnboardingBloc(this._onboardingRepository) : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) => emit(OnboardingLoading()));
    on<OnboardingUserVerified>(_onUserVerified);
  }

  void _onUserVerified(
    OnboardingUserVerified event,
    Emitter<OnboardingState> emit,
  ) async {
    LeLog.bd(this, _onUserVerified, event.birthDate.toString());
    try {
      final _ = await _onboardingRepository.onboardingVerifyingUse(
        fullName: event.fullName,
        birthDate: event.birthDate,
      );
      LeLog.bd(this, _onUserVerified, "User Profile Created");
      emit(OnboardingSuccess());
    } catch (e) {
      LeLog.bd(this, _onUserVerified, e.toString());
      emit(OnboardingFailure());
    }
  }
}
