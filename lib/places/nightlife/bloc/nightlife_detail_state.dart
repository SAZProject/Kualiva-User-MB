part of 'nightlife_detail_bloc.dart';

@immutable
sealed class NightlifeDetailState {}

final class NightlifeDetailInitial extends NightlifeDetailState {}

final class NightlifeDetailLoading extends NightlifeDetailState {}

final class NightlifeDetailSuccess extends NightlifeDetailState {
  final NightlifeDetailModel nightlifeDetail;

  NightlifeDetailSuccess({
    required this.nightlifeDetail,
  });
}

final class NightlifeDetailFailure extends NightlifeDetailState {}
