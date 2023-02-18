part of 'tv_season_detail_bloc.dart';

abstract class TvSeasonDetailEvent extends Equatable {
  const TvSeasonDetailEvent();

  @override
  List<Object> get props => [];
}

class TvSeasonDetailStarted extends TvSeasonDetailEvent {
  final int id;
  final int season;

  const TvSeasonDetailStarted({required this.id, required this.season});

  @override
  List<Object> get props => [id, season];
}
