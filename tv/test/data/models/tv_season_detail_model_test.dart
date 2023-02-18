import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSeasonModel = TvSeasonsDetailModel(
    airDate: 'airDate',
    episodes: [],
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tTVSeasonMap = {
    "air_date": "airDate",
    "episodes": [],
    "id": 1,
    "name": "name",
    "overview": "overview",
    "poster_path": "posterPath",
    "season_number": 1,
  };

  test('should be Map of season', () async {
    expect(tSeasonModel.toJson(), tTVSeasonMap);
  });
}