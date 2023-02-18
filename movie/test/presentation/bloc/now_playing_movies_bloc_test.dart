import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

  test('initial state should be [NowPlayingLoading]', () {
    expect(nowPlayingMoviesBloc.state, NowPlayingMoviesLoading());
  });

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'emits [NowPlayingMoviesError] when NowPlayingMoviesStarted is added but return error',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('error')));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingMoviesStarted()),
    expect: () => [
      NowPlayingMoviesLoading(),
      const NowPlayingMoviesError('error'),
    ],
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'emits [NowPlayingMoviesEmpty] when NowPlayingMoviesStarted is added but empty',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingMoviesStarted()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesEmpty(),
    ],
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'emits [NowPlayingMoviesSuccess] when NowPlayingMoviesStarted is added.',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right([testMovie]));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingMoviesStarted()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesSuccess([testMovie]),
    ],
  );
}
