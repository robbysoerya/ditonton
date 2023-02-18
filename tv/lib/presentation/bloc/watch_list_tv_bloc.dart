import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'watch_list_tv_event.dart';
part 'watch_list_tv_state.dart';

class WatchListTVBloc extends Bloc<WatchListTVEvent, WatchListTVState> {
  final GetWatchlistTV getWatchlistTV;
  WatchListTVBloc(this.getWatchlistTV) : super(WatchListTVLoading()) {
    on<WatchListTVStarted>(_onWatchListTVStarted);
  }

  _onWatchListTVStarted(
    WatchListTVStarted event,
    Emitter<WatchListTVState> emit,
  ) async {
    emit(WatchListTVLoading());
    final result = await getWatchlistTV.execute();
    result.fold(
      (failure) => emit(WatchListTVError(failure.message)),
      (tv) {
        if (tv.isEmpty) {
          emit(WatchListTVEmpty());
        } else {
          emit(WatchListTVSuccess(tv));
        }
      },
    );
  }
}
