import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/domain/domain.dart';

class NowPlayingTVNotifier extends ChangeNotifier {
  final GetOnTheAirTV getOnTheAirTV;

  NowPlayingTVNotifier(this.getOnTheAirTV);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TV> _tv = [];
  List<TV> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTV() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTV.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _tv = moviesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
