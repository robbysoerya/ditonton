import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv/domain/domain.dart';

class PopularTVNotifier extends ChangeNotifier {
  final GetPopularTV getPopularTV;

  PopularTVNotifier({
    required this.getPopularTV,
  });

  List<TV> _popularTV = [];
  List<TV> get popularTV => _popularTV;

  RequestState _popularTVState = RequestState.empty;
  RequestState get popularTVState => _popularTVState;

  String _message = '';
  String get message => _message;

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
}
