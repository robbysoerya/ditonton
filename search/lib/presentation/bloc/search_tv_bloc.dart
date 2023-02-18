import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/domain.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTV _searchTV;
  SearchTvBloc(this._searchTV) : super(SearchTVInitial()) {
    on<OnQueryTVChanged>(
      _onQueryChanged,
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }

  _onQueryChanged(
    OnQueryTVChanged event,
    Emitter<SearchTvState> emit,
  ) async {
    emit(SearchTVLoading());
    final result = await _searchTV.execute(event.query);
    result.fold(
      (failure) => emit(SearchTVError(message: failure.message)),
      (data) => data.isEmpty
          ? emit(SearchTVEmpty())
          : emit(SearchTVHasData(result: data)),
    );
  }
}
