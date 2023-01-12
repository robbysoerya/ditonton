import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter/material.dart';

class TVDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetWatchListStatusTV getWatchListStatus;
  final SaveWatchlistTV saveWatchlist;
  final RemoveWatchlistTV removeWatchlist;

  TVDetailNotifier({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TVDetail _tvDetail;

  TVDetail get tvDetail => _tvDetail;

  RequestState _tvDetailState = RequestState.empty;

  RequestState get tvDetailState => _tvDetailState;

  List<TV> _tvRecommendations = [];

  List<TV> get tvRecommendations => _tvRecommendations;

  RequestState _tvRecommendationsState = RequestState.empty;

  RequestState get tvRecommendationsState => _tvRecommendationsState;

  String _message = '';

  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchTVDetail(int id) async {
    _tvDetailState = RequestState.loading;
    notifyListeners();

    final result = await getTVDetail.execute(id);
    final recommendations = await getTVRecommendations.execute(id);
    result.fold(
      (failure) {
        _tvDetailState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _tvRecommendationsState = RequestState.loading;
        notifyListeners();

        recommendations.fold(
          (failure) {
            _tvRecommendationsState = RequestState.error;
            _message = failure.message;
          },
          (tvDataRecommendation) {
            _tvRecommendationsState = RequestState.loaded;
            _tvRecommendations = tvDataRecommendation;
          },
        );

        _tvDetailState = RequestState.loaded;
        _tvDetail = tvData;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TVDetail tv) async {
    final result = await saveWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TVDetail tv) async {
    final result = await removeWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
