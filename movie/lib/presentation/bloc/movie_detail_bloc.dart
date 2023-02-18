import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/domain.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailLoading()) {
    on<MovieDetailStarted>(_onMovieDetailStarted);
    on<OnAddWatchList>(_onAddWatchList);
    on<OnRemoveWatchList>(_onRemoveWatchList);
  }

  _onAddWatchList(
    OnAddWatchList event,
    Emitter<MovieDetailState> emit,
  ) async {
    final currentState = state as MovieDetailSuccess;
    final result = await saveWatchlist.execute(event.movie);
    final status = await getWatchListStatus.execute(event.movie.id);
    result.fold(
      (failure) => emit(currentState.copyWith(
        message: failure.message,
      )),
      (successMessage) => emit(currentState.copyWith(
        message: successMessage,
        isAddedWatchList: status,
      )),
    );
  }

  _onRemoveWatchList(
    OnRemoveWatchList event,
    Emitter<MovieDetailState> emit,
  ) async {
    final currentState = state as MovieDetailSuccess;
    final result = await removeWatchlist.execute(event.movie);
    final status = await getWatchListStatus.execute(event.movie.id);
    result.fold(
      (failure) => emit(currentState.copyWith(
        message: failure.message,
      )),
      (successMessage) => emit(currentState.copyWith(
        message: successMessage,
        isAddedWatchList: status,
      )),
    );
  }

  _onMovieDetailStarted(
    MovieDetailStarted event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult = await getMovieRecommendations.execute(
      event.id,
    );
    final status = await getWatchListStatus.execute(event.id);

    detailResult.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (movie) {
        recommendationResult.fold(
          (failure) => emit(MovieDetailError(failure.message)),
          (recommendations) => emit(
            MovieDetailSuccess(
              movie: movie,
              recommendations: recommendations,
              isAddedWatchList: status,
            ),
          ),
        );
      },
    );
  }
}
