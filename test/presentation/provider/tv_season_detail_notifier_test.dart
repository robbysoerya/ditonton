import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_season_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_season_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVSeasonDetail,
])
void main() {
  late TVSeasonDetailNotifier provider;
  late MockGetTVSeasonDetail mockGetTVSeasonDetail;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeasonDetail = MockGetTVSeasonDetail();
    provider = TVSeasonDetailNotifier(
      getTVSeasonDetail: mockGetTVSeasonDetail,
    )
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
  final tSeason = 1;

  void _arrangeUsecase() {
    when(mockGetTVSeasonDetail.execute(tId,tSeason))
        .thenAnswer((_) async => Right(testTVSeasonDetail));
  }

  group('Get TV Season Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVSeasonDetail(tId,tSeason);
      // assert
      verify(mockGetTVSeasonDetail.execute(tId,tSeason));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTVSeasonDetail(tId,tSeason);
      // assert
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv season detail when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVSeasonDetail(tId,tSeason);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvSeasons, testTVSeasonDetail);
      expect(listenerCallCount, 2);
    });

    group('on Error', () {
      test('should return error when data is unsuccessful', () async {
        // arrange
        when(mockGetTVSeasonDetail.execute(tId,tSeason))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        // act
        await provider.fetchTVSeasonDetail(tId,tSeason);
        // assert
        expect(provider.state, RequestState.Error);
        expect(provider.message, 'Server Failure');
        expect(listenerCallCount, 2);
      });
    });
  });
}
