import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {

  test('should be map of TV Detail', () async {
    final result = testTVDetailResponse.toJson();
    expect(result, testTVDetailMap);
  });
}