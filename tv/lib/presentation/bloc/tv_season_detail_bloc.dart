import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_season_detail_event.dart';
part 'tv_season_detail_state.dart';

class TvSeasonDetailBloc
    extends Bloc<TvSeasonDetailEvent, TvSeasonDetailState> {
  final GetTVSeasonDetail getTVSeasonDetail;
  TvSeasonDetailBloc(this.getTVSeasonDetail) : super(TvSeasonDetailInitial()) {
    on<TvSeasonDetailStarted>(_onTVSeasonDetailStarted);
  }

  _onTVSeasonDetailStarted(
    TvSeasonDetailStarted event,
    Emitter<TvSeasonDetailState> emit,
  ) async {
    emit(TvSeasonDetailLoading());
    final result = await getTVSeasonDetail.execute(event.id, event.season);
    result.fold(
      (failure) => emit(TvSeasonDetailError(failure.message)),
      (seasonsDetail) => emit(TvSeasonDetailSuccess(seasonsDetail)),
    );
  }
}
