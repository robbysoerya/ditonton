import 'package:ditonton/data/models/last_episode_to_air_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tLastEpisode = LastEpisodeToAirModel(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tLastEpisodeMap = {
    "air_date": "airDate",
    "episode_number": 1,
    "id": 1,
    "name": "name",
    "overview": "overview",
    "production_code": "productionCode",
    "season_number": 1,
    "show_id": 1,
    "still_path": "stillPath",
    "vote_average": 1,
    "vote_count": 1,
  };

  test('should be Map of Last Episode', () async {
    final result = tLastEpisode.toJson();
    expect(result, tLastEpisodeMap);
  });
}