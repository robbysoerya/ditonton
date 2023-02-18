part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesEmpty extends TopRatedMoviesState {}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  const TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMoviesSuccess extends TopRatedMoviesState {
  final List<Movie> movies;

  const TopRatedMoviesSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}
