import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/usecase.dart';
import 'package:tv/presentation/bloc/bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTV])
void main() {
  late MockGetTopRatedTV mockGetTopRatedTV;
  late TopRatedTVBloc topRatedTVBloc;

  setUp(() {
    mockGetTopRatedTV = MockGetTopRatedTV();
    topRatedTVBloc = TopRatedTVBloc(mockGetTopRatedTV);
  });

  test('initial state should be [TopRatedTVLoading]', () {
    expect(topRatedTVBloc.state, TopRatedTVLoading());
  });

  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'emits [TopRatedTVError] when TopRatedTVStarted is added but error',
    build: () {
      when(mockGetTopRatedTV.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('error')),
      );
      return topRatedTVBloc;
    },
    act: (bloc) => bloc.add(TopRatedTVStarted()),
    expect: () => [
      TopRatedTVLoading(),
      const TopRatedTVError('error'),
    ],
  );

  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'emits [TopRatedTVEmpty] when TopRatedTVStarted is added but empty',
    build: () {
      when(mockGetTopRatedTV.execute()).thenAnswer(
        (_) async => const Right([]),
      );
      return topRatedTVBloc;
    },
    act: (bloc) => bloc.add(TopRatedTVStarted()),
    expect: () => [
      TopRatedTVLoading(),
      TopRatedTVEmpty(),
    ],
  );

  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'emits [TopRatedTVSuccess] when TopRatedTVStarted is added',
    build: () {
      when(mockGetTopRatedTV.execute()).thenAnswer(
        (_) async => Right([testTV]),
      );
      return topRatedTVBloc;
    },
    act: (bloc) => bloc.add(TopRatedTVStarted()),
    expect: () => [
      TopRatedTVLoading(),
      TopRatedTVSuccess([testTV]),
    ],
  );
}
