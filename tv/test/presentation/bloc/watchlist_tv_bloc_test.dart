import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/usecase.dart';
import 'package:tv/presentation/bloc/bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTV])
void main() {
  late MockGetWatchlistTV mockGetWatchlistTV;
  late WatchListTVBloc watchListTVBloc;
  setUp(() {
    mockGetWatchlistTV = MockGetWatchlistTV();
    watchListTVBloc = WatchListTVBloc(mockGetWatchlistTV);
  });

  test('initial state should be [WatchListTVLoading]', (() {
    expect(watchListTVBloc.state, WatchListTVLoading());
  }));

  blocTest<WatchListTVBloc, WatchListTVState>(
    'emits [WatchListTVError] when WatchListTVStarted is added but error',
    build: () {
      when(mockGetWatchlistTV.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('error')),
      );
      return watchListTVBloc;
    },
    act: (bloc) => bloc.add(WatchListTVStarted()),
    expect: () => [
      WatchListTVLoading(),
      const WatchListTVError('error'),
    ],
  );

  blocTest<WatchListTVBloc, WatchListTVState>(
    'emits [WatchListTVEmpty] when WatchListTVStarted is added but empty',
    build: () {
      when(mockGetWatchlistTV.execute()).thenAnswer(
        (_) async => const Right([]),
      );
      return watchListTVBloc;
    },
    act: (bloc) => bloc.add(WatchListTVStarted()),
    expect: () => [
      WatchListTVLoading(),
      WatchListTVEmpty(),
    ],
  );

  blocTest<WatchListTVBloc, WatchListTVState>(
    'emits [WatchListTVSuccess] when WatchListTVStarted is added',
    build: () {
      when(mockGetWatchlistTV.execute()).thenAnswer(
        (_) async => Right([testTV]),
      );
      return watchListTVBloc;
    },
    act: (bloc) => bloc.add(WatchListTVStarted()),
    expect: () => [
      WatchListTVLoading(),
      WatchListTVSuccess([testTV]),
    ],
  );
}
