part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailStarted extends MovieDetailEvent {
  final int id;

  const MovieDetailStarted(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddWatchList extends MovieDetailEvent {
  final MovieDetail movie;

  const OnAddWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveWatchList extends MovieDetailEvent {
  final MovieDetail movie;

  const OnRemoveWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnLoadWatchListStatus extends MovieDetailEvent {
  final int id;

  const OnLoadWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
