import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import '../../../core/lib/common/failure.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import '../../../core/lib/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTV, GetPopularTV, GetTopRatedTV])
void main() {
  late TVListNotifier provider;
  late MockGetOnTheAirTV mockGetOnTheAirTV;
  late MockGetPopularTV mockGetPopularTV;
  late MockGetTopRatedTV mockGetTopRatedTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTV = MockGetOnTheAirTV();
    mockGetPopularTV = MockGetPopularTV();
    mockGetTopRatedTV = MockGetTopRatedTV();
    provider = TVListNotifier(
      getOnTheAirTV: mockGetOnTheAirTV,
      getPopularTV: mockGetPopularTV,
      getTopRatedTV: mockGetTopRatedTV,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTV = TV(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTVList = <TV>[tTV];

  group('on the air tv', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirTVState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTV.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnTheAirTV();
      // assert
      verify(mockGetOnTheAirTV.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTV.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchOnTheAirTV();
      // assert
      expect(provider.onTheAirTVState, RequestState.loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTV.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchOnTheAirTV();
      // assert
      expect(provider.onTheAirTVState, RequestState.loaded);
      expect(provider.onTheAirTV, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTV();
      // assert
      expect(provider.onTheAirTVState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchPopularTV();
      // assert
      expect(provider.popularTVState, RequestState.loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchPopularTV();
      // assert
      expect(provider.popularTVState, RequestState.loaded);
      expect(provider.popularTV, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTV();
      // assert
      expect(provider.popularTVState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTopRatedTV();
      // assert
      expect(provider.topRatedTVState, RequestState.loading);
    });

    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTopRatedTV();
      // assert
      expect(provider.topRatedTVState, RequestState.loaded);
      expect(provider.topRatedTV, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTV();
      // assert
      expect(provider.topRatedTVState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
