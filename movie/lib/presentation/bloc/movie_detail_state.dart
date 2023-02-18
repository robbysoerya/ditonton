part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailSuccess extends MovieDetailState {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchList;
  final String? message;

  const MovieDetailSuccess({
    required this.movie,
    required this.recommendations,
    required this.isAddedWatchList,
    this.message,
  });

  MovieDetailSuccess copyWith({
    bool? isAddedWatchList,
    String? message,
  }) {
    return MovieDetailSuccess(
      movie: movie,
      recommendations: recommendations,
      isAddedWatchList: isAddedWatchList ?? this.isAddedWatchList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        movie,
        recommendations,
        isAddedWatchList,
        message,
      ];
}
