import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/domain.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTVBloc extends Bloc<NowPlayingTVEvent, NowPlayingTVState> {
  final GetOnTheAirTV getNowPlayingTV;
  NowPlayingTVBloc(this.getNowPlayingTV) : super(NowPlayingTVLoading()) {
    on<NowPlayingTVStarted>(_onNowPlayingMoviesStarted);
  }

  _onNowPlayingMoviesStarted(
    NowPlayingTVStarted event,
    Emitter<NowPlayingTVState> emit,
  ) async {
    emit(NowPlayingTVLoading());
    final result = await getNowPlayingTV.execute();
    result.fold(
      (failure) => emit(NowPlayingTVError(failure.message)),
      (movies) {
        if (movies.isEmpty) {
          emit(NowPlayingTVEmpty());
        } else {
          emit(NowPlayingTVSuccess(movies));
        }
      },
    );
  }
}
