import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVRecommendations,
  GetWatchListStatusTV,
  SaveWatchlistTV,
  RemoveWatchlistTV,
])
void main() {
  late TVDetailBloc tvDetailBloc;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetWatchListStatusTV mockGetWatchListStatus;
  late MockSaveWatchlistTV mockSaveWatchlist;
  late MockRemoveWatchlistTV mockRemoveWatchlist;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatusTV();
    mockSaveWatchlist = MockSaveWatchlistTV();
    mockRemoveWatchlist = MockRemoveWatchlistTV();

    tvDetailBloc = TVDetailBloc(
      getTVDetail: mockGetTVDetail,
      getTVRecommendations: mockGetTVRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  test('initial state should be [TVDetailLoading]', () {
    expect(tvDetailBloc.state, TVDetailLoading());
  });

  int tId = 1;

  void arrangeUsecase() {
    when(mockGetTVDetail.execute(tId))
        .thenAnswer((_) async => const Right(testTVDetail));
    when(mockGetTVRecommendations.execute(tId))
        .thenAnswer((_) async => Right([testTV]));
    when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
  }

  blocTest<TVDetailBloc, TVDetailState>(
    'emits [TVDetailError] when unsuccessfull',
    build: () {
      arrangeUsecase();
      when(mockGetTVDetail.execute(tId)).thenAnswer(
        (_) async => const Left(ServerFailure('error')),
      );
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(TVDetailStarted(tId)),
    expect: () => [
      TVDetailLoading(),
      const TVDetailError('error'),
    ],
  );

  blocTest<TVDetailBloc, TVDetailState>(
    'emits [TVDetailSuccess] when successfull',
    build: () {
      arrangeUsecase();
      when(mockGetTVDetail.execute(tId)).thenAnswer(
        (_) async => const Right(testTVDetail),
      );
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(TVDetailStarted(tId)),
    expect: () => [
      TVDetailLoading(),
      TVDetailSuccess(
        tv: testTVDetail,
        recommendations: [testTV],
        isAddedWatchList: true,
      ),
    ],
  );

  blocTest<TVDetailBloc, TVDetailState>(
    'emits [TVDetailSuccess] with isAddedWatchList true when add event OnAddWatchList',
    build: () {
      arrangeUsecase();
      when(mockGetTVDetail.execute(tId)).thenAnswer(
        (_) async => const Right(testTVDetail),
      );
      when(mockSaveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => const Right('add to watchlist success'));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return tvDetailBloc;
    },
    seed: () => TVDetailSuccess(
        tv: testTVDetail,
        recommendations: [testTV],
        isAddedWatchList: false,
        message: 'add to watchlist success'),
    act: (bloc) => bloc.add(const OnAddWatchList(testTVDetail)),
    expect: () => [
      TVDetailSuccess(
          tv: testTVDetail,
          recommendations: [testTV],
          isAddedWatchList: true,
          message: 'add to watchlist success'),
    ],
  );

  blocTest<TVDetailBloc, TVDetailState>(
    'emits [TVDetailSuccess] with isAddedWatchList false when add event OnRemoveWatchList',
    build: () {
      arrangeUsecase();
      when(mockGetTVDetail.execute(tId)).thenAnswer(
        (_) async => const Right(testTVDetail),
      );
      when(mockRemoveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => const Right('remove watchlist success'));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => false);
      return tvDetailBloc;
    },
    seed: () => TVDetailSuccess(
        tv: testTVDetail,
        recommendations: [testTV],
        isAddedWatchList: true,
        message: 'remove watchlist success'),
    act: (bloc) => bloc.add(const OnRemoveWatchList(testTVDetail)),
    expect: () => [
      TVDetailSuccess(
          tv: testTVDetail,
          recommendations: [testTV],
          isAddedWatchList: false,
          message: 'remove watchlist success'),
    ],
  );
}
