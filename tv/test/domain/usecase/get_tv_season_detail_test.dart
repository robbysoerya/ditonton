import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTVSeasonDetail usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVSeasonDetail(mockTVRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;

  test('should get tv season detail from the repository', () async {
    // arrange
    when(mockTVRepository.getSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(testTVSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, const Right(testTVSeasonDetail));
  });
}
