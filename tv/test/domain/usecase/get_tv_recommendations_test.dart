import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetTVRecommendations usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVRecommendations(mockTVRepository);
  });

  const tId = 1;
  final tTVList = <TV>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTVRepository.getTVRecommendations(tId))
        .thenAnswer((_) async => Right(tTVList));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTVList));
  });
}
