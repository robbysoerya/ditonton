import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/tv_seasons_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=b9954067298c35b6301e1ed52ec1b307';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air TV', () {
    final tTVList = TVResponse.fromJson(json.decode(
        readJson('dummy_data/tv_on_the_air.json'))).tvList;
    test('should return list of TV Model when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_on_the_air.json'), 200));
      //act
      final result = await dataSource.getOnTheAirTV();
      //assert
      expect(result, equals(tTVList));
    });

    test('should return ServerException when the response code is 404 or other', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response('Not found', 404));
      //act
      final result = dataSource.getOnTheAirTV();
      //assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('get popular TV', () {
    final tTVList = TVResponse.fromJson(json.decode(
        readJson('dummy_data/tv_popular.json'))).tvList;

    test('should return list of TV Model when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_popular.json'),200));
      //act
      final result = await dataSource.getPopularTV();
      //assert
      expect(result, equals(tTVList));
    });

    test('should return ServerException when the response code is 404 or other', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not found', 404));
      //act
      final result = dataSource.getPopularTV();
      //assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated TV', () {
    final tTVList = TVResponse.fromJson(json.decode(
        readJson('dummy_data/tv_top_rated.json'))).tvList;
    test('should return list of TV model when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_top_rated.json'), 200));
      //act
      final result = await dataSource.getTopRatedTV();
      //assert
      expect(result, equals(tTVList));
    });

    test('should return ServerException when the response code is 404 or other', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not found', 404));
      //act
      final result = dataSource.getTopRatedTV();
      //assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('get recommendations TV', () {
    final tTVList = TVResponse.fromJson(json.decode(
        readJson('dummy_data/tv_recommendations.json'))).tvList;
    final tId = 64122;

    test('should return list of TV model when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_recommendations.json'), 200));
      //act
      final result = await dataSource.getTVRecommendations(tId);
      //assert
      expect(result, equals(tTVList));
    });

    test('should return ServerException when the response code is 404 or other', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not found', 404));
      //act
      final result = dataSource.getTVRecommendations(tId);
      //assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('get TV detail', () {
    final tTVDetail = TVDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));
    final tId = 1;
    
    test('should return TV detail model when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_detail.json'), 200));
      //act
      final result = await dataSource.getTVDetail(tId);
      //assert
      expect(result, tTVDetail);
    });

    test('should return ServerException when the response code is 404 or other', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not found', 404));
      //act
      final result = dataSource.getTVDetail(tId);
      //assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
  
  group('search TV Game Of Thrones', () {
    final tTVList = TVResponse.fromJson(json.decode(
        readJson('dummy_data/search_game_of_thrones_tv.json'))).tvList;
    final tQuery = 'Game of Thrones';

    test('should return list of TV model when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/search_game_of_thrones_tv.json'), 200));
      //act
      final result = await dataSource.searchTV(tQuery);
      //assert
      expect(result, equals(tTVList));
    });

    test('should return ServerException when the response code is 404 or other', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not found', 404));
      //act
      final result = dataSource.searchTV(tQuery);
      //assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
  
  group('TV season detail', () {
    final tId = 1;
    final tSeason = 1;
    final tTVSeasonDetail = TvSeasonsDetailModel.fromJson(json.decode(readJson('dummy_data/tv_season_detail.json')));

    test('should return TV season model when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/season/$tSeason?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_season_detail.json'), 200));
      //act
      final result = await dataSource.getSeasonDetail(tId, tSeason);
      //assert
      expect(result, equals(tTVSeasonDetail));
    });

    test('should return ServerException when the response code is 404 or other', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/season/$tSeason?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not found',404));
      //act
      final result = dataSource.getSeasonDetail(tId, tSeason);
      //assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
}