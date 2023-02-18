import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTVTable = TVTable(
    id: 1,
    name: "name",
    posterPath: "posterPath",
    overview: "overview",
  );

  final tTVTableMap = {
    "id": 1,
    "name": "name",
    "posterPath": "posterPath",
    "overview": "overview",
  };

  test('should be Map of TVTable', () async {
    final result = tTVTable.toJson();
    expect(result, tTVTableMap);
  });
}
