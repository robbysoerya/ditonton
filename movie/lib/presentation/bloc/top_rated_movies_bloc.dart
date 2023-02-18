import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMoviesBloc(this.getTopRatedMovies) : super(TopRatedMoviesLoading()) {
    on<TopRatedMoviesStarted>(_onTopRatedMoviesStarted);
  }

  _onTopRatedMoviesStarted(
    TopRatedMoviesStarted event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    emit(TopRatedMoviesLoading());
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(TopRatedMoviesError(failure.message)),
      (movies) {
        if (movies.isEmpty) {
          emit(TopRatedMoviesEmpty());
        } else {
          emit(TopRatedMoviesSuccess(movies));
        }
      },
    );
  }
}
