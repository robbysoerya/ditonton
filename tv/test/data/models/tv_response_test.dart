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

  const tTVResponseModel = TVResponse(tvList: [tTVModel]);
  final tTVResponseMap = {
    "results":
    [
      {
        "backdrop_path": 'backdropPath',
        "first_air_date": 'firstAirDate',
        "genre_ids": [1, 2, 3],
        "id": 1,
        "name": 'name',
        'original_country': ['1', '2'],
        "original_language": 'originalLanguage',
        "original_name": 'originalName',
        "overview": 'overview',
        "popularity": 1.0,
        "poster_path": 'posterPath',
        "vote_average": 1,
        "vote_count": 1,
      }
    ]
  };

  test('should be Map of TV Response', () async {
    final result = tTVResponseModel.toJson();
    expect(result, tTVResponseMap);
  });

  test('should be equals object of TV Response', () async  {
    expect(tTVResponseModel.props, equals([[tTVModel]]));
  });
}