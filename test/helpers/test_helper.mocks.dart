// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:convert' as _i27;
import 'dart:typed_data' as _i28;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i9;
import 'package:ditonton/common/network_info.dart' as _i26;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i24;
import 'package:ditonton/data/datasources/movie_local_data_source.dart' as _i14;
import 'package:ditonton/data/datasources/movie_remote_data_source.dart'
    as _i12;
import 'package:ditonton/data/datasources/tv_local_data_source.dart' as _i22;
import 'package:ditonton/data/datasources/tv_remote_data_source.dart' as _i20;
import 'package:ditonton/data/models/movie_detail_model.dart' as _i3;
import 'package:ditonton/data/models/movie_model.dart' as _i13;
import 'package:ditonton/data/models/movie_table.dart' as _i15;
import 'package:ditonton/data/models/tv_detail_model.dart' as _i4;
import 'package:ditonton/data/models/tv_model.dart' as _i21;
import 'package:ditonton/data/models/tv_seasons_detail_model.dart' as _i5;
import 'package:ditonton/data/models/tv_table.dart' as _i23;
import 'package:ditonton/domain/entities/movie.dart' as _i10;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i11;
import 'package:ditonton/domain/entities/tv.dart' as _i17;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i18;
import 'package:ditonton/domain/entities/tv_seasons_detail.dart' as _i19;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i16;
import 'package:http/http.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i25;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTVDetailResponse_2 extends _i1.SmartFake
    implements _i4.TVDetailResponse {
  _FakeTVDetailResponse_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvSeasonsModel_3 extends _i1.SmartFake
    implements _i5.TvSeasonsDetailModel {
  _FakeTvSeasonsModel_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeResponse_4 extends _i1.SmartFake implements _i6.Response {
  _FakeResponse_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeStreamedResponse_5 extends _i1.SmartFake
    implements _i6.StreamedResponse {
  _FakeStreamedResponse_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i7.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                      _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
                          this, Invocation.method(#getNowPlayingMovies, []))))
          as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
              returnValue:
                  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                      _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
                          this, Invocation.method(#getPopularMovies, []))))
          as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
              returnValue:
                  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                      _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
                          this, Invocation.method(#getTopRatedMovies, []))))
          as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, _i11.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue:
                  _i8.Future<_i2.Either<_i9.Failure, _i11.MovieDetail>>.value(
                      _FakeEither_0<_i9.Failure, _i11.MovieDetail>(
                          this, Invocation.method(#getMovieDetail, [id]))))
          as _i8.Future<_i2.Either<_i9.Failure, _i11.MovieDetail>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                      _FakeEither_0<_i9.Failure, List<_i10.Movie>>(this,
                          Invocation.method(#getMovieRecommendations, [id]))))
          as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                      _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
                          this, Invocation.method(#searchMovies, [query]))))
          as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> saveWatchlist(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>(
                      this, Invocation.method(#saveWatchlist, [movie]))))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> removeWatchlist(
          _i11.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>(
                      this, Invocation.method(#removeWatchlist, [movie]))))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: _i8.Future<bool>.value(false)) as _i8.Future<bool>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue:
                  _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>.value(
                      _FakeEither_0<_i9.Failure, List<_i10.Movie>>(
                          this, Invocation.method(#getWatchlistMovies, []))))
          as _i8.Future<_i2.Either<_i9.Failure, List<_i10.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i12.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i13.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
          as _i8.Future<List<_i13.MovieModel>>);
  @override
  _i8.Future<List<_i13.MovieModel>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
              returnValue:
                  _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
          as _i8.Future<List<_i13.MovieModel>>);
  @override
  _i8.Future<List<_i13.MovieModel>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
              returnValue:
                  _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
          as _i8.Future<List<_i13.MovieModel>>);
  @override
  _i8.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: _i8.Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1(
                      this, Invocation.method(#getMovieDetail, [id]))))
          as _i8.Future<_i3.MovieDetailResponse>);
  @override
  _i8.Future<List<_i13.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
          as _i8.Future<List<_i13.MovieModel>>);
  @override
  _i8.Future<List<_i13.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  _i8.Future<List<_i13.MovieModel>>.value(<_i13.MovieModel>[]))
          as _i8.Future<List<_i13.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i14.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<String> insertWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: _i8.Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<String> removeWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: _i8.Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<_i15.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: _i8.Future<_i15.MovieTable?>.value())
          as _i8.Future<_i15.MovieTable?>);
  @override
  _i8.Future<List<_i15.MovieTable>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue:
                  _i8.Future<List<_i15.MovieTable>>.value(<_i15.MovieTable>[]))
          as _i8.Future<List<_i15.MovieTable>>);
  @override
  _i8.Future<void> cacheNowPlayingMovies(List<_i15.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
              returnValue: _i8.Future<void>.value(),
              returnValueForMissingStub: _i8.Future<void>.value())
          as _i8.Future<void>);
  @override
  _i8.Future<List<_i15.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  _i8.Future<List<_i15.MovieTable>>.value(<_i15.MovieTable>[]))
          as _i8.Future<List<_i15.MovieTable>>);
}

/// A class which mocks [TVRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVRepository extends _i1.Mock implements _i16.TVRepository {
  MockTVRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>> getOnTheAirTV() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTV, []),
          returnValue: _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TV>>(
                  this, Invocation.method(#getOnTheAirTV, [])))) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TV>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>> getPopularTV() =>
      (super.noSuchMethod(Invocation.method(#getPopularTV, []),
          returnValue: _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TV>>(
                  this, Invocation.method(#getPopularTV, [])))) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TV>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>> getTopRatedTV() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTV, []),
          returnValue: _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TV>>(
                  this, Invocation.method(#getTopRatedTV, [])))) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TV>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, _i18.TVDetail>> getTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVDetail, [id]),
          returnValue: _i8.Future<_i2.Either<_i9.Failure, _i18.TVDetail>>.value(
              _FakeEither_0<_i9.Failure, _i18.TVDetail>(
                  this, Invocation.method(#getTVDetail, [id])))) as _i8
          .Future<_i2.Either<_i9.Failure, _i18.TVDetail>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>> getTVRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVRecommendations, [id]),
          returnValue: _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TV>>(
                  this, Invocation.method(#getTVRecommendations, [id])))) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TV>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>> searchTV(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTV, [query]),
          returnValue: _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TV>>(
                  this, Invocation.method(#searchTV, [query])))) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TV>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> saveWatchlist(
          _i18.TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tv]),
              returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>(
                      this, Invocation.method(#saveWatchlist, [tv]))))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, String>> removeWatchlist(
          _i18.TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
              returnValue: _i8.Future<_i2.Either<_i9.Failure, String>>.value(
                  _FakeEither_0<_i9.Failure, String>(
                      this, Invocation.method(#removeWatchlist, [tv]))))
          as _i8.Future<_i2.Either<_i9.Failure, String>>);
  @override
  _i8.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: _i8.Future<bool>.value(false)) as _i8.Future<bool>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>> getWatchlistTV() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTV, []),
          returnValue: _i8.Future<_i2.Either<_i9.Failure, List<_i17.TV>>>.value(
              _FakeEither_0<_i9.Failure, List<_i17.TV>>(
                  this, Invocation.method(#getWatchlistTV, [])))) as _i8
          .Future<_i2.Either<_i9.Failure, List<_i17.TV>>>);
  @override
  _i8.Future<_i2.Either<_i9.Failure, _i19.TVSeasonsDetail>> getSeasonDetail(
          int? id, int? season) =>
      (super.noSuchMethod(Invocation.method(#getSeasonDetail, [id, season]),
              returnValue:
                  _i8.Future<_i2.Either<_i9.Failure, _i19.TVSeasonsDetail>>.value(
                      _FakeEither_0<_i9.Failure, _i19.TVSeasonsDetail>(this,
                          Invocation.method(#getSeasonDetail, [id, season]))))
          as _i8.Future<_i2.Either<_i9.Failure, _i19.TVSeasonsDetail>>);
}

/// A class which mocks [TVRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVRemoteDataSource extends _i1.Mock
    implements _i20.TVRemoteDataSource {
  MockTVRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<List<_i21.TVModel>> getOnTheAirTV() => (super.noSuchMethod(
          Invocation.method(#getOnTheAirTV, []),
          returnValue: _i8.Future<List<_i21.TVModel>>.value(<_i21.TVModel>[]))
      as _i8.Future<List<_i21.TVModel>>);
  @override
  _i8.Future<List<_i21.TVModel>> getPopularTV() => (super.noSuchMethod(
          Invocation.method(#getPopularTV, []),
          returnValue: _i8.Future<List<_i21.TVModel>>.value(<_i21.TVModel>[]))
      as _i8.Future<List<_i21.TVModel>>);
  @override
  _i8.Future<List<_i21.TVModel>> getTopRatedTV() => (super.noSuchMethod(
          Invocation.method(#getTopRatedTV, []),
          returnValue: _i8.Future<List<_i21.TVModel>>.value(<_i21.TVModel>[]))
      as _i8.Future<List<_i21.TVModel>>);
  @override
  _i8.Future<_i4.TVDetailResponse> getTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVDetail, [id]),
              returnValue: _i8.Future<_i4.TVDetailResponse>.value(
                  _FakeTVDetailResponse_2(
                      this, Invocation.method(#getTVDetail, [id]))))
          as _i8.Future<_i4.TVDetailResponse>);
  @override
  _i8.Future<List<_i21.TVModel>> getTVRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVRecommendations, [id]),
              returnValue:
                  _i8.Future<List<_i21.TVModel>>.value(<_i21.TVModel>[]))
          as _i8.Future<List<_i21.TVModel>>);
  @override
  _i8.Future<List<_i21.TVModel>> searchTV(String? query) => (super.noSuchMethod(
          Invocation.method(#searchTV, [query]),
          returnValue: _i8.Future<List<_i21.TVModel>>.value(<_i21.TVModel>[]))
      as _i8.Future<List<_i21.TVModel>>);
  @override
  _i8.Future<_i5.TvSeasonsDetailModel> getSeasonDetail(int? id, int? season) =>
      (super.noSuchMethod(Invocation.method(#getSeasonDetail, [id, season]),
              returnValue: _i8.Future<_i5.TvSeasonsDetailModel>.value(
                  _FakeTvSeasonsModel_3(
                      this, Invocation.method(#getSeasonDetail, [id, season]))))
          as _i8.Future<_i5.TvSeasonsDetailModel>);
}

/// A class which mocks [TVLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVLocalDataSource extends _i1.Mock implements _i22.TVLocalDataSource {
  MockTVLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<String> insertWatchlist(_i23.TVTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tv]),
          returnValue: _i8.Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<String> removeWatchlist(_i23.TVTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
          returnValue: _i8.Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<_i23.TVTable?> getTVById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVById, [id]),
              returnValue: _i8.Future<_i23.TVTable?>.value())
          as _i8.Future<_i23.TVTable?>);
  @override
  _i8.Future<List<_i23.TVTable>> getWatchlistTV() => (super.noSuchMethod(
          Invocation.method(#getWatchlistTV, []),
          returnValue: _i8.Future<List<_i23.TVTable>>.value(<_i23.TVTable>[]))
      as _i8.Future<List<_i23.TVTable>>);
  @override
  _i8.Future<void> cacheOnTheAirTV(List<_i23.TVTable>? tvList) =>
      (super.noSuchMethod(Invocation.method(#cacheOnTheAirTV, [tvList]),
              returnValue: _i8.Future<void>.value(),
              returnValueForMissingStub: _i8.Future<void>.value())
          as _i8.Future<void>);
  @override
  _i8.Future<List<_i23.TVTable>> getCachedOnTheAirTV() => (super.noSuchMethod(
          Invocation.method(#getCachedOnTheAirTV, []),
          returnValue: _i8.Future<List<_i23.TVTable>>.value(<_i23.TVTable>[]))
      as _i8.Future<List<_i23.TVTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i24.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i25.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: _i8.Future<_i25.Database?>.value())
          as _i8.Future<_i25.Database?>);
  @override
  _i8.Future<void> insertCacheTransaction(
          List<_i15.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
              Invocation.method(#insertCacheTransaction, [movies, category]),
              returnValue: _i8.Future<void>.value(),
              returnValueForMissingStub: _i8.Future<void>.value())
          as _i8.Future<void>);
  @override
  _i8.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i8.Future<List<Map<String, dynamic>>>);
  @override
  _i8.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: _i8.Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> insertWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: _i8.Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> removeWatchlist(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: _i8.Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: _i8.Future<Map<String, dynamic>?>.value())
          as _i8.Future<Map<String, dynamic>?>);
  @override
  _i8.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i8.Future<List<Map<String, dynamic>>>);
  @override
  _i8.Future<void> insertCacheTransactionTV(
          List<_i23.TVTable>? tvList, String? category) =>
      (super.noSuchMethod(
              Invocation.method(#insertCacheTransactionTV, [tvList, category]),
              returnValue: _i8.Future<void>.value(),
              returnValueForMissingStub: _i8.Future<void>.value())
          as _i8.Future<void>);
  @override
  _i8.Future<List<Map<String, dynamic>>> getCacheTV(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheTV, [category]),
              returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i8.Future<List<Map<String, dynamic>>>);
  @override
  _i8.Future<int> clearCacheTV(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCacheTV, [category]),
          returnValue: _i8.Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> insertWatchlistTV(_i23.TVTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTV, [tv]),
          returnValue: _i8.Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> removeWatchlistTV(_i23.TVTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTV, [tv]),
          returnValue: _i8.Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<Map<String, dynamic>?> getTVById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVById, [id]),
              returnValue: _i8.Future<Map<String, dynamic>?>.value())
          as _i8.Future<Map<String, dynamic>?>);
  @override
  _i8.Future<List<Map<String, dynamic>>> getWatchlistTV() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTV, []),
              returnValue: _i8.Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i8.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i26.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: _i8.Future<bool>.value(false)) as _i8.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i6.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<_i6.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
                  this, Invocation.method(#head, [url], {#headers: headers}))))
          as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
                  this, Invocation.method(#get, [url], {#headers: headers}))))
          as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#post, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
                  this,
                  Invocation.method(#post, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#put, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
                  this,
                  Invocation.method(#put, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#patch, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
                  this,
                  Invocation.method(#patch, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<_i6.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i27.Encoding? encoding}) =>
      (super
          .noSuchMethod(Invocation.method(#delete, [url], {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: _i8.Future<_i6.Response>.value(_FakeResponse_4(
                  this,
                  Invocation.method(#delete, [
                    url
                  ], {
                    #headers: headers,
                    #body: body,
                    #encoding: encoding
                  })))) as _i8.Future<_i6.Response>);
  @override
  _i8.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: _i8.Future<String>.value('')) as _i8.Future<String>);
  @override
  _i8.Future<_i28.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: _i8.Future<_i28.Uint8List>.value(_i28.Uint8List(0)))
          as _i8.Future<_i28.Uint8List>);
  @override
  _i8.Future<_i6.StreamedResponse> send(_i6.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: _i8.Future<_i6.StreamedResponse>.value(
                  _FakeStreamedResponse_5(
                      this, Invocation.method(#send, [request]))))
          as _i8.Future<_i6.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
