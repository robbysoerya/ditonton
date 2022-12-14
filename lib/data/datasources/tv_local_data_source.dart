import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_table.dart';

abstract class TVLocalDataSource {
  Future<String> insertWatchlist(TVTable tv);
  Future<String> removeWatchlist(TVTable tv);
  Future<TVTable?> getTVById(int id);
  Future<List<TVTable>> getWatchlistTV();
  Future<void> cacheOnTheAirTV(List<TVTable> tvList);
  Future<List<TVTable>> getCachedOnTheAirTV();
}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TVTable tv) async {
    try {
      await databaseHelper.insertWatchlistTV(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TVTable tv) async {
    try {
      await databaseHelper.removeWatchlistTV(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVTable?> getTVById(int id) async {
    final result = await databaseHelper.getTVById(id);
    if (result != null) {
      return TVTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVTable>> getWatchlistTV() async {
    final result = await databaseHelper.getWatchlistTV();
    return result.map((data) => TVTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheOnTheAirTV(List<TVTable> tv) async {
    await databaseHelper.clearCacheTV('on the air');
    await databaseHelper.insertCacheTransactionTV(tv,'on the air');
  }

  @override
  Future<List<TVTable>> getCachedOnTheAirTV() async {
    final result = await databaseHelper.getCacheTV('on the air');
    if (result.length > 0) {
      return result.map((data) => TVTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
