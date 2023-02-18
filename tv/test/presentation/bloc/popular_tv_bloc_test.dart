import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/usecase.dart';
import 'package:tv/presentation/bloc/bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late PopularTVBloc popularTVBloc;
  late MockGetPopularTV mockGetPopularTV;
  setUp(() {
    mockGetPopularTV = MockGetPopularTV();
    popularTVBloc = PopularTVBloc(mockGetPopularTV);
  });

  test('initial state should be [PopularTVLoading]', () {
    expect(popularTVBloc.state, PopularTVLoading());
  });

  blocTest<PopularTVBloc, PopularTVState>(
    'emits [PopularTVError] when PopularTVStarted is added.',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => const Left(ServerFailure('error')));
      return popularTVBloc;
    },
    act: (bloc) => bloc.add(PopularTVStarted()),
    expect: () => [
      PopularTVLoading(),
      const PopularTVError('error'),
    ]
  );

  blocTest<PopularTVBloc, PopularTVState>(
    'emits [PopularTVEmpty] when PopularTVStarted is added but empty',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTVBloc;
    },
    act: (bloc) => bloc.add(PopularTVStarted()),
    expect: () => [
      PopularTVLoading(),
      PopularTVEmpty(),
    ]
  );

  blocTest<PopularTVBloc, PopularTVState>(
    'emits [PopularTVSuccess] when PopularTVStarted is added.',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Right([testTV]));
      return popularTVBloc;
    },
    act: (bloc) => bloc.add(PopularTVStarted()),
    expect: () => [
      PopularTVLoading(),
      PopularTVSuccess([testTV]),
    ]
  );
}
