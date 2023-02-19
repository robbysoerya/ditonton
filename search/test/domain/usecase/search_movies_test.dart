import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  const tQuery = 'spiderman';

  test('should get movie from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async =>  Right(testMovieList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(testMovieList));
  });
}
