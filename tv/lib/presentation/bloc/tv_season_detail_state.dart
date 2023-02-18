part of 'tv_season_detail_bloc.dart';

abstract class TvSeasonDetailState extends Equatable {
  const TvSeasonDetailState();

  @override
  List<Object> get props => [];
}

class TvSeasonDetailInitial extends TvSeasonDetailState {}

class TvSeasonDetailLoading extends TvSeasonDetailState {}

class TvSeasonDetailError extends TvSeasonDetailState {
  final String message;

  const TvSeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeasonDetailSuccess extends TvSeasonDetailState {
  final TVSeasonsDetail seasonsDetail;

  const TvSeasonDetailSuccess(this.seasonsDetail);

  @override
  List<Object> get props => [seasonsDetail];
}
