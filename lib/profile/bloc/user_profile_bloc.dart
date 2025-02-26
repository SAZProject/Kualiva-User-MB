import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_data/enum/loading_enum.dart';
import 'package:kualiva/auth/model/user_model.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_repository/profile_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final ProfileRepository _profileRepository;
  UserProfileBloc(this._profileRepository) : super(UserProfileInitial()) {
    on<UserProfileFetched>(_onFetched);
    on<UserProfileUpdated>(_onUpdated);
  }

  void _onFetched(
    UserProfileFetched event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserProfileLoading(loadingState: LoadingEnum.fetch));
    try {
      final user = await _profileRepository.me();
      LeLog.bd(this, _onFetched, user.toString());
      emit(UserProfileFetchSuccess(user: user));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(UserProfileFetchFailure());
    }
  }

  void _onUpdated(
    UserProfileUpdated event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserProfileLoading(loadingState: LoadingEnum.update));
    try {
      final _ = await _profileRepository.updateProfile(
        fullName: event.fullName,
        birthDate: event.birthDate,
        gender: event.gender,
        photofile: event.photoFile,
      );
      LeLog.bd(this, _onUpdated, "Profile Updated");
      emit(UserProfileUpdateSuccess());
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(UserProfileUpdateFailure());
    }
  }
}
