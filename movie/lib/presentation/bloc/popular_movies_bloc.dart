import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesLoading()) {
    on<PopularMoviesStarted>(_onPopularMoviesStarted);
  }

  _onPopularMoviesStarted(
    PopularMoviesStarted event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) => emit(PopularMoviesError(failure.message)),
      (movies) {
        if (movies.isEmpty) {
          emit(PopularMoviesEmpty());
        } else {
          emit(PopularMoviesSuccess(movies));
        }
      },
    );
  }
}
