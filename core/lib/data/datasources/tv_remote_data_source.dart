import 'dart:convert';

import 'package:core/data/data.dart';
import 'package:core/utils/utils.dart';

abstract class TVRemoteDataSource {
  Future<List<TVModel>> getOnTheAirTV();
  Future<List<TVModel>> getPopularTV();
  Future<List<TVModel>> getTopRatedTV();
  Future<TVDetailResponse> getTVDetail(int id);
  Future<List<TVModel>> getTVRecommendations(int id);
  Future<List<TVModel>> searchTV(String query);
  Future<TvSeasonsDetailModel> getSeasonDetail(int id, int season);
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  final NetworkClient nc;

  const TVRemoteDataSourceImpl({required this.nc});

  @override
  Future<List<TVModel>> getOnTheAirTV() async {
    final client = await nc.client;
    final response =
        await client.get(Uri.parse('$kBaseUrl/tv/on_the_air?$kApiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getPopularTV() async {
    final client = await nc.client;
    final response =
        await client.get(Uri.parse('$kBaseUrl/tv/popular?$kApiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVDetailResponse> getTVDetail(int id) async {
    final client = await nc.client;
    final response = await client.get(Uri.parse('$kBaseUrl/tv/$id?$kApiKey'));

    if (response.statusCode == 200) {
      return TVDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTVRecommendations(int id) async {
    final client = await nc.client;
    final response = await client
        .get(Uri.parse('$kBaseUrl/tv/$id/recommendations?$kApiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTopRatedTV() async {
    final client = await nc.client;
    final response =
        await client.get(Uri.parse('$kBaseUrl/tv/top_rated?$kApiKey'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> searchTV(String query) async {
    final client = await nc.client;
    final response = await client
        .get(Uri.parse('$kBaseUrl/search/tv?$kApiKey&query=$query'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeasonsDetailModel> getSeasonDetail(int id, int season) async {
    final client = await nc.client;
    final response =
        await client.get(Uri.parse('$kBaseUrl/tv/$id/season/$season?$kApiKey'));

    if (response.statusCode == 200) {
      return TvSeasonsDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
