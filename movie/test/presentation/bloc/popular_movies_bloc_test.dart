import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;
  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  test('initial state should be [PopularMoviesLoading]', () {
    expect(popularMoviesBloc.state, PopularMoviesLoading());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesError] when PopularMoviesStarted is added.',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('error')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(PopularMoviesStarted()),
      expect: () => [
            PopularMoviesLoading(),
            const PopularMoviesError('error'),
          ]);

  blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesEmpty] when PopularMoviesStarted is added but empty',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(PopularMoviesStarted()),
      expect: () => [
            PopularMoviesLoading(),
            PopularMoviesEmpty(),
          ]);

  blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesSuccess] when PopularMoviesStarted is added.',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(PopularMoviesStarted()),
      expect: () => [
            PopularMoviesLoading(),
            PopularMoviesSuccess([testMovie]),
          ]);
}
