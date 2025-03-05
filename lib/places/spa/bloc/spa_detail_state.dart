part of 'spa_detail_bloc.dart';

@immutable
sealed class SpaDetailState {}

final class SpaDetailInitial extends SpaDetailState {}

final class SpaDetailLoading extends SpaDetailState {}

final class SpaDetailSuccess extends SpaDetailState {
  final SpaDetailModel spaDetail;

  SpaDetailSuccess({
    required this.spaDetail,
  });
}

final class SpaDetailFailure extends SpaDetailState {}
