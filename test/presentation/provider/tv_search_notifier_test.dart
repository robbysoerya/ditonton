import 'package:dartz/dartz.dart';
import '../../../core/lib/common/failure.dart';
import '../../../core/lib/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late TVSearchNotifier provider;
  late MockSearchTV mockSearchTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTV = MockSearchTV();
    provider = TVSearchNotifier(searchTV: mockSearchTV)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTV = TV(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tTVList = <TV>[tTV];
  final tQuery = 'spiderman';

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchResult, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
