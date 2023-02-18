import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieTable = MovieTable(
    id: 1, 
    title: "title", 
    posterPath: "posterPath", 
    overview: "overview",
  );

  final tMovieTableMap = {
    "id": 1,
    "title": "title",
    "posterPath": "posterPath",
    "overview": "overview",
  };

  test('should be Map of MovieTable', () async {
    final result = tMovieTable.toJson();
    expect(result, tMovieTableMap);
  });
}