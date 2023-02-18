import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTVModel = TVModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: ['1','2'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
  );

  final tTV = TV(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: const ['1','2'],
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVMap = {
    "backdrop_path": 'backdropPath',
    "first_air_date": 'firstAirDate',
    "genre_ids": [1, 2, 3],
    "id": 1,
    "name": 'name',
    'original_country': ['1','2'],
    "original_language": 'originalLanguage',
    "original_name": 'originalName',
    "overview": 'overview',
    "popularity": 1.0,
    "poster_path": 'posterPath',
    "vote_average": 1,
    "vote_count": 1,
  };

  test('should be a subclass of TV entity', () async {
    final result = tTVModel.toEntity();
    expect(result, tTV);
  });

  test('should be a Map of TV model', () async {
    final result = tTVModel.toJson();
    expect(result, tTVMap);
  });
}
