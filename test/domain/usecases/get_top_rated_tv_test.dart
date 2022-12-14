import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTopRatedTV(mockTVRepository);
  });

  final tTVList = <TV>[];

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTVRepository.getTopRatedTV())
        .thenAnswer((_) async => Right(tTVList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVList));
  });
}
