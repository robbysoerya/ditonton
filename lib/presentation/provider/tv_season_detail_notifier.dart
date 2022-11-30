import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_seasons_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter/foundation.dart';

class TVSeasonDetailNotifier extends ChangeNotifier {
  final GetTVSeasonDetail getTVSeasonDetail;

  TVSeasonDetailNotifier({required this.getTVSeasonDetail});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  late TVSeasonsDetail _tvSeasons;
  TVSeasonsDetail get tvSeasons => _tvSeasons;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSeasonDetail(int id, int season) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTVSeasonDetail.execute(id,season);
    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (data) {
        _tvSeasons = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
