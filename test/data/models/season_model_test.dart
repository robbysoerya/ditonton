import 'package:ditonton/data/models/seasons_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonsModel(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
  );

  final tSeasonMap = {
    "air_date": "airDate",
    "episode_count": 1,
    "id": 1,
    "name": "name",
    "overview": "overview",
    "poster_path": "posterPath",
    "season_number": 1,
  };

  test('should be Map of season', () async {
    expect(tSeasonModel.toJson(), tSeasonMap);
  });
}