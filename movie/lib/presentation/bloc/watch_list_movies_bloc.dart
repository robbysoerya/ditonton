import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';

part 'watch_list_movies_event.dart';
part 'watch_list_movies_state.dart';

class WatchListMoviesBloc
    extends Bloc<WatchListMoviesEvent, WatchListMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchListMoviesBloc(this.getWatchlistMovies)
      : super(WatchListMoviesLoading()) {
    on<WatchListMoviesStarted>(_onWatchListMoviesStarted);
  }

  _onWatchListMoviesStarted(
    WatchListMoviesStarted event,
    Emitter<WatchListMoviesState> emit,
  ) async {
    emit(WatchListMoviesLoading());
    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) => emit(WatchListMoviesError(failure.message)),
      (movies) {
        if (movies.isEmpty) {
          emit(WatchListMoviesEmpty());
        } else {
          emit(WatchListMoviesSuccess(movies));
        }
      },
    );
  }
}
