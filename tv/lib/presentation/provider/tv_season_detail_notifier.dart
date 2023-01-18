import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/domain/domain.dart';

class TVSeasonDetailNotifier extends ChangeNotifier {
  final GetTVSeasonDetail getTVSeasonDetail;

  TVSeasonDetailNotifier({required this.getTVSeasonDetail});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  late TVSeasonsDetail _tvSeasons;
  TVSeasonsDetail get tvSeasons => _tvSeasons;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSeasonDetail(int id, int season) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTVSeasonDetail.execute(id, season);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _tvSeasons = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
