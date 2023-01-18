import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/domain/domain.dart';

class WatchlistTVNotifier extends ChangeNotifier {
  var _watchlistTV = <TV>[];
  List<TV> get watchlistTV => _watchlistTV;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTVNotifier({required this.getWatchlistTV});

  final GetWatchlistTV getWatchlistTV;

  Future<void> fetchWatchlistTV() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTV.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.loaded;
        _watchlistTV = tvData;
        notifyListeners();
      },
    );
  }
}
