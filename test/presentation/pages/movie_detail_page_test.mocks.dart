// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/pages/movie_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i13;
import 'dart:ui' as _i14;

import '../../../core/lib/common/state_enum.dart' as _i11;
import 'package:ditonton/domain/entities/movie.dart' as _i12;
import 'package:ditonton/domain/entities/movie_detail.dart' as _i7;
import 'package:ditonton/domain/usecases/get_movie_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart' as _i3;
import 'package:ditonton/domain/usecases/get_watchlist_status.dart' as _i4;
import 'package:ditonton/domain/usecases/remove_watchlist.dart' as _i6;
import 'package:ditonton/domain/usecases/save_watchlist.dart' as _i5;
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart'
    as _i10;
import 'package:flutter/foundation.dart' as _i9;
import 'package:flutter/material.dart' as _i8;
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

class _FakeGetMovieDetail_0 extends _i1.SmartFake
    implements _i2.GetMovieDetail {
  _FakeGetMovieDetail_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetMovieRecommendations_1 extends _i1.SmartFake
    implements _i3.GetMovieRecommendations {
  _FakeGetMovieRecommendations_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetWatchListStatus_2 extends _i1.SmartFake
    implements _i4.GetWatchListStatus {
  _FakeGetWatchListStatus_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSaveWatchlist_3 extends _i1.SmartFake implements _i5.SaveWatchlist {
  _FakeSaveWatchlist_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRemoveWatchlist_4 extends _i1.SmartFake
    implements _i6.RemoveWatchlist {
  _FakeRemoveWatchlist_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeMovieDetail_5 extends _i1.SmartFake implements _i7.MovieDetail {
  _FakeMovieDetail_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeWidget_6 extends _i1.SmartFake implements _i8.Widget {
  _FakeWidget_6(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);

  @override
  String toString({_i9.DiagnosticLevel? minLevel = _i9.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedWidget_7 extends _i1.SmartFake
    implements _i8.InheritedWidget {
  _FakeInheritedWidget_7(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);

  @override
  String toString({_i9.DiagnosticLevel? minLevel = _i9.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_8 extends _i1.SmartFake
    implements _i9.DiagnosticsNode {
  _FakeDiagnosticsNode_8(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);

  @override
  String toString(
          {_i9.TextTreeConfiguration? parentConfiguration,
          _i9.DiagnosticLevel? minLevel = _i9.DiagnosticLevel.info}) =>
      super.toString();
}

/// A class which mocks [MovieDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailNotifier extends _i1.Mock
    implements _i10.MovieDetailNotifier {
  MockMovieDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetMovieDetail get getMovieDetail => (super.noSuchMethod(
          Invocation.getter(#getMovieDetail),
          returnValue:
              _FakeGetMovieDetail_0(this, Invocation.getter(#getMovieDetail)))
      as _i2.GetMovieDetail);
  @override
  _i3.GetMovieRecommendations get getMovieRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getMovieRecommendations),
              returnValue: _FakeGetMovieRecommendations_1(
                  this, Invocation.getter(#getMovieRecommendations)))
          as _i3.GetMovieRecommendations);
  @override
  _i4.GetWatchListStatus get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
              returnValue: _FakeGetWatchListStatus_2(
                  this, Invocation.getter(#getWatchListStatus)))
          as _i4.GetWatchListStatus);
  @override
  _i5.SaveWatchlist get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
              returnValue:
                  _FakeSaveWatchlist_3(this, Invocation.getter(#saveWatchlist)))
          as _i5.SaveWatchlist);
  @override
  _i6.RemoveWatchlist get removeWatchlist => (super.noSuchMethod(
          Invocation.getter(#removeWatchlist),
          returnValue:
              _FakeRemoveWatchlist_4(this, Invocation.getter(#removeWatchlist)))
      as _i6.RemoveWatchlist);
  @override
  _i7.MovieDetail get movie => (super.noSuchMethod(Invocation.getter(#movie),
          returnValue: _FakeMovieDetail_5(this, Invocation.getter(#movie)))
      as _i7.MovieDetail);
  @override
  _i11.RequestState get movieState =>
      (super.noSuchMethod(Invocation.getter(#movieState),
          returnValue: _i11.RequestState.empty) as _i11.RequestState);
  @override
  List<_i12.Movie> get movieRecommendations =>
      (super.noSuchMethod(Invocation.getter(#movieRecommendations),
          returnValue: <_i12.Movie>[]) as List<_i12.Movie>);
  @override
  _i11.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
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
  _i13.Future<void> fetchMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#fetchMovieDetail, [id]),
              returnValue: _i13.Future<void>.value(),
              returnValueForMissingStub: _i13.Future<void>.value())
          as _i13.Future<void>);
  @override
  _i13.Future<void> addWatchlist(_i7.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [movie]),
              returnValue: _i13.Future<void>.value(),
              returnValueForMissingStub: _i13.Future<void>.value())
          as _i13.Future<void>);
  @override
  _i13.Future<void> removeFromWatchlist(_i7.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlist, [movie]),
              returnValue: _i13.Future<void>.value(),
              returnValueForMissingStub: _i13.Future<void>.value())
          as _i13.Future<void>);
  @override
  _i13.Future<void> loadWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
              returnValue: _i13.Future<void>.value(),
              returnValueForMissingStub: _i13.Future<void>.value())
          as _i13.Future<void>);
  @override
  void addListener(_i14.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i14.VoidCallback? listener) =>
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

/// A class which mocks [BuildContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockBuildContext extends _i1.Mock implements _i8.BuildContext {
  MockBuildContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Widget get widget => (super.noSuchMethod(Invocation.getter(#widget),
          returnValue: _FakeWidget_6(this, Invocation.getter(#widget)))
      as _i8.Widget);
  @override
  bool get debugDoingBuild => (super
          .noSuchMethod(Invocation.getter(#debugDoingBuild), returnValue: false)
      as bool);
  @override
  _i8.InheritedWidget dependOnInheritedElement(_i8.InheritedElement? ancestor,
          {Object? aspect}) =>
      (super.noSuchMethod(
          Invocation.method(
              #dependOnInheritedElement, [ancestor], {#aspect: aspect}),
          returnValue: _FakeInheritedWidget_7(
              this,
              Invocation.method(#dependOnInheritedElement, [ancestor],
                  {#aspect: aspect}))) as _i8.InheritedWidget);
  @override
  void visitAncestorElements(bool Function(_i8.Element)? visitor) =>
      super.noSuchMethod(Invocation.method(#visitAncestorElements, [visitor]),
          returnValueForMissingStub: null);
  @override
  void visitChildElements(_i8.ElementVisitor? visitor) =>
      super.noSuchMethod(Invocation.method(#visitChildElements, [visitor]),
          returnValueForMissingStub: null);
  @override
  void dispatchNotification(_i8.Notification? notification) => super
      .noSuchMethod(Invocation.method(#dispatchNotification, [notification]),
          returnValueForMissingStub: null);
  @override
  _i9.DiagnosticsNode describeElement(String? name,
          {_i9.DiagnosticsTreeStyle? style =
              _i9.DiagnosticsTreeStyle.errorProperty}) =>
      (super.noSuchMethod(
              Invocation.method(#describeElement, [name], {#style: style}),
              returnValue: _FakeDiagnosticsNode_8(this,
                  Invocation.method(#describeElement, [name], {#style: style})))
          as _i9.DiagnosticsNode);
  @override
  _i9.DiagnosticsNode describeWidget(String? name,
          {_i9.DiagnosticsTreeStyle? style =
              _i9.DiagnosticsTreeStyle.errorProperty}) =>
      (super.noSuchMethod(
              Invocation.method(#describeWidget, [name], {#style: style}),
              returnValue: _FakeDiagnosticsNode_8(this,
                  Invocation.method(#describeWidget, [name], {#style: style})))
          as _i9.DiagnosticsNode);
  @override
  List<_i9.DiagnosticsNode> describeMissingAncestor(
          {Type? expectedAncestorType}) =>
      (super.noSuchMethod(
          Invocation.method(#describeMissingAncestor, [],
              {#expectedAncestorType: expectedAncestorType}),
          returnValue: <_i9.DiagnosticsNode>[]) as List<_i9.DiagnosticsNode>);
  @override
  _i9.DiagnosticsNode describeOwnershipChain(String? name) =>
      (super.noSuchMethod(Invocation.method(#describeOwnershipChain, [name]),
              returnValue: _FakeDiagnosticsNode_8(
                  this, Invocation.method(#describeOwnershipChain, [name])))
          as _i9.DiagnosticsNode);
}

/// A class which mocks [NavigatorObserver].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigatorObserver extends _i1.Mock implements _i8.NavigatorObserver {
  @override
  void didPush(_i8.Route<dynamic>? route, _i8.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPush, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didPop(_i8.Route<dynamic>? route, _i8.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPop, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didRemove(
          _i8.Route<dynamic>? route, _i8.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didRemove, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didReplace(
          {_i8.Route<dynamic>? newRoute, _i8.Route<dynamic>? oldRoute}) =>
      super.noSuchMethod(
          Invocation.method(
              #didReplace, [], {#newRoute: newRoute, #oldRoute: oldRoute}),
          returnValueForMissingStub: null);
  @override
  void didStartUserGesture(
          _i8.Route<dynamic>? route, _i8.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(
          Invocation.method(#didStartUserGesture, [route, previousRoute]),
          returnValueForMissingStub: null);
  @override
  void didStopUserGesture() =>
      super.noSuchMethod(Invocation.method(#didStopUserGesture, []),
          returnValueForMissingStub: null);
}
