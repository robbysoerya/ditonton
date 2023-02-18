import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  SearchBloc(this._searchMovies) : super(SearchInitial()) {
    on<OnQueryChanged>(
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
    OnQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading()); 
    final result = await _searchMovies.execute(event.query);
    result.fold(
      (failure) => emit(SearchError(message: failure.message)),
      (data) => data.isEmpty
          ? emit(SearchEmpty())
          : emit(SearchHasData(result: data)),
    );
  }
}
