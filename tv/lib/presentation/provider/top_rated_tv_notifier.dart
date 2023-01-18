import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/domain.dart';

class TopRatedTVNotifier extends ChangeNotifier {
  final GetTopRatedTV getTopRatedTV;

  TopRatedTVNotifier({
    required this.getTopRatedTV,
  });

  List<TV> _topRatedTV = [];

  List<TV> get topRatedTV => _topRatedTV;

  RequestState _topRatedTVState = RequestState.empty;

  RequestState get topRatedTVState => _topRatedTVState;

  String _message = '';

  String get message => _message;

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
