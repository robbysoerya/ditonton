import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late SearchTvBloc searchBloc;
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchTV = MockSearchTV();
    searchBloc = SearchTvBloc(mockSearchTV);
  });

  test('initial state should be initial', () {
    expect(searchBloc.state, SearchTVInitial());
  });

  final tTvModel = TV(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: const ['1', '2'],
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvList = <TV>[tTvModel];
  const tQuery = 'spiderman';

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTVChanged(query: tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTVLoading(),
      SearchTVHasData(result: tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );
  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Empty] when get search is successfull but empty',
    build: () {
      when(mockSearchTV.execute(tQuery)).thenAnswer(
        (_) async => const Right([]),
      );
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTVChanged(query: tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTVLoading(),
      SearchTVEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );
  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTV.execute(tQuery)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryTVChanged(query: tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTVLoading(),
      const SearchTVError(message: 'Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );
}
