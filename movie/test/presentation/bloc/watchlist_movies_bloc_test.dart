import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchListMoviesBloc watchListMoviesBloc;
  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchListMoviesBloc = WatchListMoviesBloc(mockGetWatchlistMovies);
  });

  test('initial state should be [WatchListMoviesLoading]', (() {
    expect(watchListMoviesBloc.state, WatchListMoviesLoading());
  }));

  blocTest<WatchListMoviesBloc, WatchListMoviesState>(
    'emits [WatchListMoviesError] when WatchListMoviesStarted is added but error',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('error')),
      );
      return watchListMoviesBloc;
    },
    act: (bloc) => bloc.add(WatchListMoviesStarted()),
    expect: () => [
      WatchListMoviesLoading(),
      const WatchListMoviesError('error'),
    ],
  );

  blocTest<WatchListMoviesBloc, WatchListMoviesState>(
    'emits [WatchListMoviesEmpty] when WatchListMoviesStarted is added but empty',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => const Right([]),
      );
      return watchListMoviesBloc;
    },
    act: (bloc) => bloc.add(WatchListMoviesStarted()),
    expect: () => [
      WatchListMoviesLoading(),
      WatchListMoviesEmpty(),
    ],
  );

  blocTest<WatchListMoviesBloc, WatchListMoviesState>(
    'emits [WatchListMoviesSuccess] when WatchListMoviesStarted is added',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => Right([testMovie]),
      );
      return watchListMoviesBloc;
    },
    act: (bloc) => bloc.add(WatchListMoviesStarted()),
    expect: () => [
      WatchListMoviesLoading(),
      WatchListMoviesSuccess([testMovie]),
    ],
  );
}
