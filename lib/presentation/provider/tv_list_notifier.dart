import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TVListNotifier extends ChangeNotifier {
  var _onTheAirTV = <TV>[];

  List<TV> get onTheAirTV => _onTheAirTV;

  RequestState _onTheAirTVState = RequestState.empty;

  RequestState get onTheAirTVState => _onTheAirTVState;

  var _popularTV = <TV>[];

  List<TV> get popularTV => _popularTV;

  RequestState _popularTVState = RequestState.empty;

  RequestState get popularTVState => _popularTVState;

  var _topRatedTV = <TV>[];

  List<TV> get topRatedTV => _topRatedTV;

  RequestState _topRatedTVState = RequestState.empty;

  RequestState get topRatedTVState => _topRatedTVState;

  String _message = '';

  String get message => _message;

  final GetOnTheAirTV getOnTheAirTV;
  final GetPopularTV getPopularTV;
  final GetTopRatedTV getTopRatedTV;

  TVListNotifier({
    required this.getOnTheAirTV,
    required this.getPopularTV,
    required this.getTopRatedTV,
  });

  Future<void> fetchOnTheAirTV() async {
    _onTheAirTVState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTV.execute();
    result.fold(
      (failure) {
        _onTheAirTVState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onTheAirTVState = RequestState.loaded;
        _onTheAirTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTV() async {
    _popularTVState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTV.execute();
    result.fold(
      (failure) {
        _popularTVState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTVState = RequestState.loaded;
        _popularTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTV() async {
    _topRatedTVState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();
    result.fold(
      (failure) {
        _topRatedTVState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTVState = RequestState.loaded;
        _topRatedTV = tvData;
        notifyListeners();
      },
    );
  }
}
