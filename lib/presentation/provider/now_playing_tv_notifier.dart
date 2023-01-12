import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:flutter/foundation.dart';

class NowPlayingTVNotifier extends ChangeNotifier {
  final GetOnTheAirTV getOnTheAirTV;

  NowPlayingTVNotifier(this.getOnTheAirTV);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _tv = [];
  List<TV> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTV() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTV.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _tv = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
