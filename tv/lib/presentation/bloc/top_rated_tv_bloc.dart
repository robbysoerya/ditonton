import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTVBloc extends Bloc<TopRatedTVEvent, TopRatedTVState> {
  final GetTopRatedTV getTopRatedTV;
  TopRatedTVBloc(this.getTopRatedTV) : super(TopRatedTVLoading()) {
    on<TopRatedTVStarted>(_onTopRatedTVStarted);
  }

  _onTopRatedTVStarted(
    TopRatedTVStarted event,
    Emitter<TopRatedTVState> emit,
  ) async {
    emit(TopRatedTVLoading());
    final result = await getTopRatedTV.execute();
    result.fold(
      (failure) => emit(TopRatedTVError(failure.message)),
      (tv) {
        if (tv.isEmpty) {
          emit(TopRatedTVEmpty());
        } else {
          emit(TopRatedTVSuccess(tv));
        }
      },
    );
  }
}
