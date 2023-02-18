import 'dart:convert';

import 'package:core/data/data.dart';
import 'package:core/utils/utils.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final NetworkClient nc;

  MovieRemoteDataSourceImpl({required this.nc});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final client = await nc.client;
    final response =
        await client.get(Uri.parse('$kBaseUrl/movie/now_playing?$kApiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final client = await nc.client;
    final response =
        await client.get(Uri.parse('$kBaseUrl/movie/$id?$kApiKey'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final client = await nc.client;
    final response = await client
        .get(Uri.parse('$kBaseUrl/movie/$id/recommendations?$kApiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final client = await nc.client;
    final response =
        await client.get(Uri.parse('$kBaseUrl/movie/popular?$kApiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final client = await nc.client;
    final response =
        await client.get(Uri.parse('$kBaseUrl/movie/top_rated?$kApiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final client = await nc.client;
    final response = await client
        .get(Uri.parse('$kBaseUrl/search/movie?$kApiKey&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
