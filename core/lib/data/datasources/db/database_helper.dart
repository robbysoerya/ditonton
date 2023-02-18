import 'dart:async';

import 'package:core/data/data.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _tblCache = 'cache';

  static const String _tblWatchListTV = 'watchlist_tv';
  static const String _tblCacheTV = 'cache_tv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton1.db';

    var db = await openDatabase(databasePath, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE $_tblCache (
      id INTEGER PRIMARY KEY,
      title TEXT,
      overview TEXT,
      posterPath TEXT,
      category TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblWatchListTV (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE $_tblCacheTV (
      id INTEGER PRIMARY KEY,
      name TEXT,
      overview TEXT,
      posterPath TEXT,
      category TEXT
      );
    ''');
  }

  Future<void> insertCacheTransaction(
    List<MovieTable> movies,
    String category,
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(_tblCache, movieJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheMovies(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
    return results;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  //TV
  Future<void> insertCacheTransactionTV(
    List<TVTable> tvList,
    String category,
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final tv in tvList) {
        final tvJson = tv.toJson();
        tvJson['category'] = category;
        txn.insert(_tblCacheTV, tvJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTV(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheTV,
      where: 'category = ?',
      whereArgs: [category],
    );
    return results;
  }

  Future<int> clearCacheTV(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheTV,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlistTV(TVTable tv) async {
    final db = await database;
    return await db!.insert(_tblWatchListTV, tv.toJson());
  }

  Future<int> removeWatchlistTV(TVTable tv) async {
    final db = await database;
    return await db!.delete(
      _tblWatchListTV,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTVById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchListTV,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTV() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchListTV);

    return results;
  }
}
