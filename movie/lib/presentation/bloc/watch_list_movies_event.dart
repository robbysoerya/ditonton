part of 'watch_list_movies_bloc.dart';

abstract class WatchListMoviesEvent extends Equatable {
  const WatchListMoviesEvent();

  @override
  List<Object> get props => [];
}

class WatchListMoviesStarted extends WatchListMoviesEvent {}
