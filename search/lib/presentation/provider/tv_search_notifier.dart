import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:search/domain/domain.dart';

class TVSearchNotifier extends ChangeNotifier {
  final SearchTV searchTV;

  TVSearchNotifier({required this.searchTV});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TV> _searchResult = [];
  List<TV> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTV.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state =
            _searchResult.isEmpty ? RequestState.empty : RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
