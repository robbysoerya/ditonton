part of 'watch_list_movies_bloc.dart';

abstract class WatchListMoviesState extends Equatable {
  const WatchListMoviesState();

  @override
  List<Object> get props => [];
}

class WatchListMoviesLoading extends WatchListMoviesState {}

class WatchListMoviesEmpty extends WatchListMoviesState {}

class WatchListMoviesError extends WatchListMoviesState {
  final String message;

  const WatchListMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchListMoviesSuccess extends WatchListMoviesState {
  final List<Movie> movies;

  const WatchListMoviesSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}
