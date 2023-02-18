import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tEpisodeMap = {
    "air_date": 'airDate',
    "episode_number": 1,
    "id": 1,
    "name": 'name',
    "overview": 'overview',
    "production_code": 'productionCode',
    "runtime": 20,
    "season_number": 1,
    "show_id": 1,
    "still_path": 'stillPath',
    "vote_average": 1.0,
    "vote_count": 1,
  };

  test('should be a Map of Episode', () async {
    final result = testTVSeasonEpisodeModel.toJson();
    expect(result, tEpisodeMap);
  });
}