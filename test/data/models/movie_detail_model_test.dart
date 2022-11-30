import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailModel = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [GenreModel(id: 1, name: 'name')],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieDetailMap = {
    "adult": false,
    "backdrop_path": 'backdropPath',
    "budget": 1,
    "genres": [GenreModel(id: 1, name: 'name').toJson()],
    "homepage": 'homepage',
    "id": 1,
    "imdb_id": 'imdbId',
    "original_language": 'originalLanguage',
    "original_title": 'originalTitle',
    "overview": 'overview',
    "popularity": 1.0,
    "poster_path": 'posterPath',
    "release_date": 'releaseDate',
    "revenue": 1,
    "runtime": 1,
    "status": 'status',
    "tagline": 'tagline',
    "title": 'title',
    "video": false,
    "vote_average": 1.0,
    "vote_count": 1,
  };
  
  test('should be map of Movie Detail', () async {
    final result = tMovieDetailModel.toJson();
    expect(result, tMovieDetailMap);
  });
}