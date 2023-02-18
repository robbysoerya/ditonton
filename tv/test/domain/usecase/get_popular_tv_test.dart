import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetPopularTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetPopularTV(mockTVRepository);
  });

  final tTVList = <TV>[];

  group('GetPopularTV Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
              () async {
            // arrange
            when(mockTVRepository.getPopularTV())
                .thenAnswer((_) async => Right(tTVList));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTVList));
          });
    });
  });
}
