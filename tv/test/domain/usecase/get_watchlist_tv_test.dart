import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetWatchlistTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetWatchlistTV(mockTVRepository);
  });

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVRepository.getWatchlistTV())
        .thenAnswer((_) async => Right(tesTVList));
    // act
    final result = await usecase.execute();
    // assert
    verify(mockTVRepository.getWatchlistTV());
    expect(result, Right(tesTVList));
  });
}
