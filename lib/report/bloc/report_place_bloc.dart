import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kualiva/_data/model/parameter/parameter_model.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:flutter/foundation.dart';
import 'package:kualiva/_repository/report_repository.dart';

part 'report_place_event.dart';
part 'report_place_state.dart';

class ReportPlaceBloc extends Bloc<ReportPlaceEvent, ReportPlaceState> {
  final ReportRepository _reportRepository;

  ReportPlaceBloc(this._reportRepository) : super(ReportPlaceInitial()) {
    on<ReportPlaceEvent>((event, emit) {});
    on<ReportPlaceFetched>(_onFetched);
    on<ReportPlaceCreated>(_onCreated);
    on<ReportPlaceImageStored>(_onImageStored);
    on<ReportPlaceImageDisposed>(_onImageDisposed);
  }

  void _onFetched(
    ReportPlaceFetched event,
    Emitter<ReportPlaceState> emit,
  ) async {
    emit(ReportPlaceLoading());
    try {
      final ParameterModel parameter =
          await _reportRepository.getPlaceReasons();
      LeLog.bd(this, _onFetched, parameter.toString());
      emit(ReportPlaceFetchSuccess(parameter: parameter));
    } catch (e) {
      LeLog.be(this, _onFetched, e.toString());
      emit(ReportPlaceFetchFailure());
    }
  }

  void _onCreated(
    ReportPlaceCreated event,
    Emitter<ReportPlaceState> emit,
  ) async {
    emit(ReportPlaceLoading());
    try {
      final _ = await _reportRepository.create(
        placeId: event.placeId,
        reasonId: event.reasonId,
      );
      LeLog.bd(this, _onCreated, 'Success Created PlaceReport');
      emit(ReportPlaceCreatedSuccess());
    } catch (e) {
      LeLog.bd(this, _onCreated, e.toString());
      emit(ReportPlaceCreatedFailure());
    }
  }

  void _onImageStored(
    ReportPlaceImageStored event,
    Emitter<ReportPlaceState> emit,
  ) async {
    _reportRepository.imageStore(imagePaths: event.imagePaths);
  }

  void _onImageDisposed(
    ReportPlaceImageDisposed event,
    Emitter<ReportPlaceState> emit,
  ) {
    _reportRepository.imageDispose();
  }
}
