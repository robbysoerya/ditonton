import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTVBloc extends Bloc<PopularTVEvent, PopularTVState> {
  final GetPopularTV getPopularTV;
  PopularTVBloc(this.getPopularTV) : super(PopularTVLoading()) {
    on<PopularTVStarted>(_onPopularTVStarted);
  }

  _onPopularTVStarted(
    PopularTVStarted event,
    Emitter<PopularTVState> emit,
  ) async {
    emit(PopularTVLoading());
    final result = await getPopularTV.execute();
    result.fold(
      (failure) => emit(PopularTVError(failure.message)),
      (tv) {
        if (tv.isEmpty) {
          emit(PopularTVEmpty());
        } else {
          emit(PopularTVSuccess(tv));
        }
      },
    );
  }
}
