import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();

    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  test('initial state should be [MovieDetailLoading]', () {
    expect(movieDetailBloc.state, MovieDetailLoading());
  });

  int tId = 1;

  void arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right([testMovie]));
    when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
  }

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailError] when unsuccessfull',
    build: () {
      arrangeUsecase();
      when(mockGetMovieDetail.execute(tId)).thenAnswer(
        (_) async => const Left(ServerFailure('error')),
      );
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(MovieDetailStarted(tId)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError('error'),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailSuccess] when successfull',
    build: () {
      arrangeUsecase();
      when(mockGetMovieDetail.execute(tId)).thenAnswer(
        (_) async => const Right(testMovieDetail),
      );
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(MovieDetailStarted(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailSuccess(
        movie: testMovieDetail,
        recommendations: [testMovie],
        isAddedWatchList: true,
      ),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailError] when failed',
    build: () {
      arrangeUsecase();
      when(mockGetMovieDetail.execute(tId)).thenAnswer(
        (_) async => const Left(ServerFailure('')),
      );
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(MovieDetailStarted(tId)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError(''),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailSuccess] with isAddedWatchList true when add event OnAddWatchList',
    build: () {
      arrangeUsecase();
      when(mockGetMovieDetail.execute(tId)).thenAnswer(
        (_) async => const Right(testMovieDetail),
      );
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('add to watchlist success'));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return movieDetailBloc;
    },
    seed: () => MovieDetailSuccess(
        movie: testMovieDetail,
        recommendations: [testMovie],
        isAddedWatchList: false,
        message: 'add to watchlist success'),
    act: (bloc) => bloc.add(const OnAddWatchList(testMovieDetail)),
    expect: () => [
      MovieDetailSuccess(
          movie: testMovieDetail,
          recommendations: [testMovie],
          isAddedWatchList: true,
          message: 'add to watchlist success'),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailError] with isAddedWatchList true when add event OnAddWatchList',
    build: () {
      arrangeUsecase();
      when(mockGetMovieDetail.execute(tId)).thenAnswer(
        (_) async => const Right(testMovieDetail),
      );
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('add to watchlist failed')));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return movieDetailBloc;
    },
    seed: () => MovieDetailSuccess(
      movie: testMovieDetail,
      recommendations: [testMovie],
      isAddedWatchList: false,
    ),
    act: (bloc) => bloc.add(const OnAddWatchList(testMovieDetail)),
    expect: () => [
      MovieDetailSuccess(
        movie: testMovieDetail,
        recommendations: [testMovie],
        isAddedWatchList: false,
        message: 'add to watchlist failed',
      ),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailSuccess] with isAddedWatchList false when add event OnRemoveWatchList',
    build: () {
      arrangeUsecase();
      when(mockGetMovieDetail.execute(tId)).thenAnswer(
        (_) async => const Right(testMovieDetail),
      );
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('remove watchlist success'));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => false);
      return movieDetailBloc;
    },
    seed: () => MovieDetailSuccess(
        movie: testMovieDetail,
        recommendations: [testMovie],
        isAddedWatchList: true,
        message: 'remove watchlist success'),
    act: (bloc) => bloc.add(const OnRemoveWatchList(testMovieDetail)),
    expect: () => [
      MovieDetailSuccess(
          movie: testMovieDetail,
          recommendations: [testMovie],
          isAddedWatchList: false,
          message: 'remove watchlist success'),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailError] with isAddedWatchList false when add event OnRemoveWatchList',
    build: () {
      arrangeUsecase();
      when(mockGetMovieDetail.execute(tId)).thenAnswer(
        (_) async => const Right(testMovieDetail),
      );
      when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('remove watchlist failed')));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => false);
      return movieDetailBloc;
    },
    seed: () => MovieDetailSuccess(
      movie: testMovieDetail,
      recommendations: [testMovie],
      isAddedWatchList: true,
    ),
    act: (bloc) => bloc.add(const OnRemoveWatchList(testMovieDetail)),
    expect: () => [
      MovieDetailSuccess(
          movie: testMovieDetail,
          recommendations: [testMovie],
          isAddedWatchList: true,
          message: 'remove watchlist failed'),
    ],
  );
}
