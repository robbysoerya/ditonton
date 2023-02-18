import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMoviesBloc(this.getNowPlayingMovies)
      : super(NowPlayingMoviesLoading()) {
    on<NowPlayingMoviesStarted>(_onNowPlayingMoviesStarted);
  }

  _onNowPlayingMoviesStarted(
    NowPlayingMoviesStarted event,
    Emitter<NowPlayingMoviesState> emit,
  ) async {
    emit(NowPlayingMoviesLoading());
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(NowPlayingMoviesError(failure.message)),
      (movies) {
        if (movies.isEmpty) {
          emit(NowPlayingMoviesEmpty());
        } else {
          emit(NowPlayingMoviesSuccess(movies));
        }
      },
    );
  }
}
