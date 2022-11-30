import 'package:ditonton/data/models/tv_seasons_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = TvSeasonsDetailModel(
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