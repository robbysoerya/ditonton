import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/domain.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetWatchListStatusTV getWatchListStatus;
  final SaveWatchlistTV saveWatchlist;
  final RemoveWatchlistTV removeWatchlist;

  TVDetailBloc({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TVDetailLoading()) {
    on<TVDetailStarted>(_onTVDetailStarted);
    on<OnAddWatchList>(_onAddWatchList);
    on<OnRemoveWatchList>(_onRemoveWatchList);
  }

  _onAddWatchList(
    OnAddWatchList event,
    Emitter<TVDetailState> emit,
  ) async {
    final currentState = state as TVDetailSuccess;
    final result = await saveWatchlist.execute(event.tv);
    final status = await getWatchListStatus.execute(event.tv.id);
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
    Emitter<TVDetailState> emit,
  ) async {
    final currentState = state as TVDetailSuccess;
    final result = await removeWatchlist.execute(event.tv);
    final status = await getWatchListStatus.execute(event.tv.id);
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

  _onTVDetailStarted(
    TVDetailStarted event,
    Emitter<TVDetailState> emit,
  ) async {
    emit(TVDetailLoading());
    final detailResult = await getTVDetail.execute(event.id);
    final recommendationResult = await getTVRecommendations.execute(
      event.id,
    );
    final status = await getWatchListStatus.execute(event.id);

    detailResult.fold(
      (failure) => emit(TVDetailError(failure.message)),
      (tv) {
        recommendationResult.fold(
          (failure) => emit(TVDetailError(failure.message)),
          (recommendations) => emit(
            TVDetailSuccess(
              tv: tv,
              recommendations: recommendations,
              isAddedWatchList: status,
            ),
          ),
        );
      },
    );
  }
}
