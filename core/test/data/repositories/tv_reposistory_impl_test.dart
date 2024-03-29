import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import '../../../../tv/test/helper/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockDatabaseHelper mockDatabaseHelper;
  late TVLocalDataSourceImpl dataSource;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tTVModel = TVModel(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    originCountry: ['en'],
    originalLanguage: 'en',
    originalName: 'Spider-Man',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTV = TV(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    originCountry: const ['en'],
    originalLanguage: 'en',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testTVFromCache = TV(
    backdropPath: null,
    genreIds: null,
    id: 557,
    originalName: null,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: null,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: null,
    name: 'Spider-Man',
    voteAverage: null,
    voteCount: null,
  );

  final tTVModelList = <TVModel>[tTVModel];
  final tTVList = <TV>[tTV];

  group('On The Air TV', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getOnTheAirTV()).thenAnswer((_) async => []);
      //act
      await repository.getOnTheAirTV();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    const testTVCache = TVTable(
      id: 557,
      overview:
          'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      name: 'Spider-Man',
    );

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTV());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

     test(
        'should return SSLFailure when the call to remote data source with invalid certificate',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTV()).thenThrow(const TlsException());
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTV());
      expect(result, equals(const Left(SSLFailure(''))));
    });

    test(
        'should cache data locally when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRemoteDataSource.getOnTheAirTV())
          .thenAnswer((_) async => tTVModelList);
      //act
      await repository.getOnTheAirTV();
      //assert
      verify(mockRemoteDataSource.getOnTheAirTV());
      verify(mockLocalDataSource.cacheOnTheAirTV([testTVCache]));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTV()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTV());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        //arrange
        when(mockLocalDataSource.getCachedOnTheAirTV())
            .thenAnswer((_) async => [testTVCache]);
        //act
        final result = await repository.getOnTheAirTV();
        //assert
        verify(mockLocalDataSource.getCachedOnTheAirTV());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTVFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        //arrange
        when(mockLocalDataSource.getCachedOnTheAirTV())
            .thenThrow(CacheException('No Cache'));
        //act
        final result = await repository.getOnTheAirTV();
        //assert
        verify(mockLocalDataSource.getCachedOnTheAirTV());
        expect(result, const Left(CacheFailure('No Cache')));
      });
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTV())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTV());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

    group('cache on the air tv', () {
      setUp(() {
        when(mockLocalDataSource.getCachedOnTheAirTV())
            .thenAnswer((_) async => [testTVCache]);
      });
      test('should call database helper to save data', () async {
        //arrange
        when(mockDatabaseHelper.clearCacheTV('on the air'))
            .thenAnswer((_) async => 1);
        //act
        await dataSource.cacheOnTheAirTV([testTVCache]);
        //assert
        verify(mockDatabaseHelper.clearCacheTV('on the air'));
        verify(mockDatabaseHelper
            .insertCacheTransactionTV([testTVCache], 'on the air'));
      });

      final testTVCacheMap = {
        'id': 557,
        'overview':
            'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
        'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
        'name': 'Spider-Man',
      };

      test('should return list of tv from db when data exist', () async {
        //arrange
        when(mockDatabaseHelper.getCacheTV('on the air'))
            .thenAnswer((_) async => [testTVCacheMap]);
        //act
        final result = await dataSource.getCachedOnTheAirTV();
        //assert
        expect(result, [testTVCache]);
      });

      test('should throw CacheException when cache data is not exist',
          () async {
        //arrange
        when(mockDatabaseHelper.getCacheTV('on the air'))
            .thenAnswer((_) async => []);
        //act
        final call = dataSource.getCachedOnTheAirTV();
        //assert
        expect(() => call, throwsA(isA<CacheException>()));
      });
    });
  });

  group('Popular Movies', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getPopularTV();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });

     test(
        'should return SSLFailure when call to data source with invalid certificate',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV()).thenThrow(const TlsException());
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(result, const Left(SSLFailure('')));
    });
  });

  group('Top Rated TV', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getTopRatedTV();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });

      test('should return SSLFailure when call to data source with invalid certificate',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV()).thenThrow(const TlsException());
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(result, const Left(SSLFailure('')));
    });
  });

  group('Get TV Detail', () {
    const tId = 1;

    test(
        'should return TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenAnswer((_) async => testTVDetailResponse);
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(const Right(testTVDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

     test(
        'should return SSLFailure when the call to remote data source with invalid certificate',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(const TlsException());
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(const Left(SSLFailure(''))));
    });
  });

  group('Get TV Recommendations', () {
    final tTVList = <TVModel>[];
    const tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenAnswer((_) async => tTVList);
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

      test(
        'should return SSLFailure when call to remote data source with invalid certificate',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(const TlsException());
      // act
      final result = await repository.getTVRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result, equals(const Left(SSLFailure(''))));
    });
  });

  group('Seach TV', () {
    const tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery))
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });

     test('should return SSLFailure when call to data source with invalid certificate',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery)).thenThrow(const TlsException());
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(result, const Left(SSLFailure('')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTVTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTVTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTV())
          .thenAnswer((_) async => [testTVTable]);
      // act
      final result = await repository.getWatchlistTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });

    test('should return DatabaseFailure when unsuccessfull', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTV())
          .thenThrow(DatabaseException('Failed to get watchlist'));
      // act
      final result = await repository.getWatchlistTV();
      // assert
      expect(result, const Left(DatabaseFailure('Failed to get watchlist')));
    });
  });

  group('tv season detail', () {
    const tId = 1;
    const tSeason = 1;
    test('should return tv season detail when successfull', () async {
      //arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeason))
          .thenAnswer((_) async => testTVSeasonDetailModel);
      //act
      final result = await repository.getSeasonDetail(tId, tSeason);
      //assert
      expect(result, equals(const Right(testTVSeasonDetail)));
    });

    test('should return ServerFailure when failure', () async {
      //arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeason))
          .thenThrow(ServerException());
      //act
      final result = await repository.getSeasonDetail(tId, tSeason);
      //assert
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('should return ConnectionFailure when device is offline', () async {
      //arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeason))
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getSeasonDetail(tId, tSeason);
      //assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });

     test('should return SSLFailure when certificate invalid', () async {
      //arrange
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeason))
          .thenThrow(const TlsException());
      //act
      final result = await repository.getSeasonDetail(tId, tSeason);
      //assert
      expect(result, equals(const Left(SSLFailure(''))));
    });
  });
}
