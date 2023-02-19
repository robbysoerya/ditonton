import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SearchTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTV(mockTVRepository);
  });

  const tQuery = 'spiderman';

  test('should get tv from the repository', () async {
    // arrange
    when(mockTVRepository.searchTV(tQuery))
        .thenAnswer((_) async =>  Right(tesTVList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tesTVList));
  });
}
