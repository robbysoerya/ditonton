part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesEmpty extends PopularMoviesState {}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  const PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesSuccess extends PopularMoviesState {
  final List<Movie> movies;

  const PopularMoviesSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}
