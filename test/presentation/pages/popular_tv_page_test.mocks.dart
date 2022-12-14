// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/pages/popular_tv_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i12;
import 'dart:ui' as _i13;

import 'package:ditonton/common/state_enum.dart' as _i11;
import 'package:ditonton/domain/entities/tv.dart' as _i10;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i8;
import 'package:ditonton/domain/usecases/get_popular_tv.dart' as _i2;
import 'package:ditonton/domain/usecases/get_tv_detail.dart' as _i3;
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart' as _i4;
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart' as _i5;
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart' as _i7;
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart' as _i6;
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart' as _i9;
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeGetPopularTV_0 extends _i1.SmartFake implements _i2.GetPopularTV {
  _FakeGetPopularTV_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetTVDetail_1 extends _i1.SmartFake implements _i3.GetTVDetail {
  _FakeGetTVDetail_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetTVRecommendations_2 extends _i1.SmartFake
    implements _i4.GetTVRecommendations {
  _FakeGetTVRecommendations_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetWatchListStatusTV_3 extends _i1.SmartFake
    implements _i5.GetWatchListStatusTV {
  _FakeGetWatchListStatusTV_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSaveWatchlistTV_4 extends _i1.SmartFake
    implements _i6.SaveWatchlistTV {
  _FakeSaveWatchlistTV_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRemoveWatchlistTV_5 extends _i1.SmartFake
    implements _i7.RemoveWatchlistTV {
  _FakeRemoveWatchlistTV_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTVDetail_6 extends _i1.SmartFake implements _i8.TVDetail {
  _FakeTVDetail_6(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [PopularTVNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularTVNotifier extends _i1.Mock implements _i9.PopularTVNotifier {
  MockPopularTVNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetPopularTV get getPopularTV =>
      (super.noSuchMethod(Invocation.getter(#getPopularTV),
              returnValue:
                  _FakeGetPopularTV_0(this, Invocation.getter(#getPopularTV)))
          as _i2.GetPopularTV);
  @override
  List<_i10.TV> get popularTV => (super
          .noSuchMethod(Invocation.getter(#popularTV), returnValue: <_i10.TV>[])
      as List<_i10.TV>);
  @override
  _i11.RequestState get popularTVState =>
      (super.noSuchMethod(Invocation.getter(#popularTVState),
          returnValue: _i11.RequestState.empty) as _i11.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i12.Future<void> fetchPopularTV() =>
      (super.noSuchMethod(Invocation.method(#fetchPopularTV, []),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
          as _i12.Future<void>);
  @override
  void addListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [TVDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVDetailNotifier extends _i1.Mock implements _i14.TVDetailNotifier {
  MockTVDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.GetTVDetail get getTVDetail =>
      (super.noSuchMethod(Invocation.getter(#getTVDetail),
              returnValue:
                  _FakeGetTVDetail_1(this, Invocation.getter(#getTVDetail)))
          as _i3.GetTVDetail);
  @override
  _i4.GetTVRecommendations get getTVRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getTVRecommendations),
              returnValue: _FakeGetTVRecommendations_2(
                  this, Invocation.getter(#getTVRecommendations)))
          as _i4.GetTVRecommendations);
  @override
  _i5.GetWatchListStatusTV get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
              returnValue: _FakeGetWatchListStatusTV_3(
                  this, Invocation.getter(#getWatchListStatus)))
          as _i5.GetWatchListStatusTV);
  @override
  _i6.SaveWatchlistTV get saveWatchlist => (super.noSuchMethod(
          Invocation.getter(#saveWatchlist),
          returnValue:
              _FakeSaveWatchlistTV_4(this, Invocation.getter(#saveWatchlist)))
      as _i6.SaveWatchlistTV);
  @override
  _i7.RemoveWatchlistTV get removeWatchlist => (super.noSuchMethod(
      Invocation.getter(#removeWatchlist),
      returnValue: _FakeRemoveWatchlistTV_5(
          this, Invocation.getter(#removeWatchlist))) as _i7.RemoveWatchlistTV);
  @override
  _i8.TVDetail get tvDetail => (super.noSuchMethod(Invocation.getter(#tvDetail),
          returnValue: _FakeTVDetail_6(this, Invocation.getter(#tvDetail)))
      as _i8.TVDetail);
  @override
  _i11.RequestState get tvDetailState =>
      (super.noSuchMethod(Invocation.getter(#tvDetailState),
          returnValue: _i11.RequestState.empty) as _i11.RequestState);
  @override
  List<_i10.TV> get tvRecommendations =>
      (super.noSuchMethod(Invocation.getter(#tvRecommendations),
          returnValue: <_i10.TV>[]) as List<_i10.TV>);
  @override
  _i11.RequestState get tvRecommendationsState =>
      (super.noSuchMethod(Invocation.getter(#tvRecommendationsState),
          returnValue: _i11.RequestState.empty) as _i11.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatchlist =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlist),
          returnValue: false) as bool);
  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i12.Future<void> fetchTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#fetchTVDetail, [id]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Future<void> addWatchlist(_i8.TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [tv]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Future<void> removeFromWatchlist(_i8.TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlist, [tv]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
          as _i12.Future<void>);
  @override
  _i12.Future<void> loadWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
              returnValue: _i12.Future<void>.value(),
              returnValueForMissingStub: _i12.Future<void>.value())
          as _i12.Future<void>);
  @override
  void addListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i13.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [NavigatorObserver].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigatorObserver extends _i1.Mock implements _i15.NavigatorObserver {
  @override
  void didPush(
          _i15.Route<dynamic>? route, _i15.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPush, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didPop(_i15.Route<dynamic>? route, _i15.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPop, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didRemove(
          _i15.Route<dynamic>? route, _i15.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didRemove, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didReplace(
          {_i15.Route<dynamic>? newRoute, _i15.Route<dynamic>? oldRoute}) =>
      super.noSuchMethod(
          Invocation.method(
              #didReplace, [], {#newRoute: newRoute, #oldRoute: oldRoute}),
          returnValueForMissingStub: null);
  @override
  void didStartUserGesture(
          _i15.Route<dynamic>? route, _i15.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(
          Invocation.method(#didStartUserGesture, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didStopUserGesture() =>
      super.noSuchMethod(Invocation.method(#didStopUserGesture, []),
          returnValueForMissingStub: null);
}
