part of 'fnb_detail_bloc.dart';

@immutable
sealed class FnbDetailState {}

final class FnbDetailInitial extends FnbDetailState {}

final class FnbDetailLoading extends FnbDetailState {}

final class FnbDetailSuccess extends FnbDetailState {
  final FnbDetailModel fnbDetail;

  FnbDetailSuccess({
    required this.fnbDetail,
  });
}

final class FnbDetailFailure extends FnbDetailState {}
