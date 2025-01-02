import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/auth/model/user_model.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/profile/repository/profile_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final ProfileRepository _profileRepository;
  UserProfileBloc(this._profileRepository) : super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) => emit(UserProfileLoading()));
    on<UserProfileFetched>(_onFetched);
  }

  void _onFetched(
    UserProfileFetched event,
    Emitter<UserProfileState> emit,
  ) async {
    try {
      final user = await _profileRepository.me();
      LeLog.bd(this, _onFetched, user.toString());
      emit(UserProfileSuccess(user: user));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(UserProfileFailure());
    }
  }
}
