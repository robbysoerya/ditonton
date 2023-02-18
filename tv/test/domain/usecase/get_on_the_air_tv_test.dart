import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetOnTheAirTV(mockTVRepository);
  });

  final tTVList = <TV>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVRepository.getOnTheAirTV())
        .thenAnswer((_) async => Right(tTVList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVList));
  });
}
