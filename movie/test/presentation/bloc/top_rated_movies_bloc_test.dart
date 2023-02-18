import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
  });

  test('initial state should be [TopRatedMoviesLoading]', () {
    expect(topRatedMoviesBloc.state, TopRatedMoviesLoading());
  });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [TopRatedMoviesError] when TopRatedMoviesStarted is added but error',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('error')),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(TopRatedMoviesStarted()),
    expect: () => [
      TopRatedMoviesLoading(),
      const TopRatedMoviesError('error'),
    ],
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [TopRatedMoviesEmpty] when TopRatedMoviesStarted is added but empty',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => const Right([]),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(TopRatedMoviesStarted()),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesEmpty(),
    ],
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [TopRatedMoviesSuccess] when TopRatedMoviesStarted is added',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => Right([testMovie]),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(TopRatedMoviesStarted()),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesSuccess([testMovie]),
    ],
  );
}
