// Mocks generated by Mockito 5.3.2 from annotations
// in tv/test/presentation/bloc/tv_detail_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/domain/domain.dart' as _i2;
import 'package:core/utils/utils.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/usecase/get_tv_detail.dart' as _i4;
import 'package:tv/domain/usecase/get_tv_recommendations.dart' as _i7;
import 'package:tv/domain/usecase/get_watchlist_status_tv.dart' as _i8;
import 'package:tv/domain/usecase/remove_watchlist_tv.dart' as _i10;
import 'package:tv/domain/usecase/save_watchlist_tv.dart' as _i9;

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

class _FakeTVRepository_0 extends _i1.SmartFake implements _i2.TVRepository {
  _FakeTVRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTVDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVDetail extends _i1.Mock implements _i4.GetTVDetail {
  MockGetTVDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i2.TVDetail>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i2.TVDetail>>.value(
            _FakeEither_1<_i6.Failure, _i2.TVDetail>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i2.TVDetail>>);
}

/// A class which mocks [GetTVRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVRecommendations extends _i1.Mock
    implements _i7.GetTVRecommendations {
  MockGetTVRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i2.TV>>> execute(dynamic id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i2.TV>>>.value(
            _FakeEither_1<_i6.Failure, List<_i2.TV>>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i2.TV>>>);
}

/// A class which mocks [GetWatchListStatusTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusTV extends _i1.Mock
    implements _i8.GetWatchListStatusTV {
  MockGetWatchListStatusTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVRepository);
  @override
  _i5.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlistTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTV extends _i1.Mock implements _i9.SaveWatchlistTV {
  MockSaveWatchlistTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i2.TVDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tv],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tv],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTV].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTV extends _i1.Mock implements _i10.RemoveWatchlistTV {
  MockRemoveWatchlistTV() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTVRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i2.TVDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tv],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tv],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}
