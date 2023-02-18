import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTV])
void main() {
  late NowPlayingTVBloc nowPlayingTVBloc;
  late MockGetOnTheAirTV mockGetNowPlayingTV;

  setUp(() {
    mockGetNowPlayingTV = MockGetOnTheAirTV();
    nowPlayingTVBloc = NowPlayingTVBloc(mockGetNowPlayingTV);
  });

  test('initial state should be [NowPlayingLoading]', () {
    expect(nowPlayingTVBloc.state, NowPlayingTVLoading());
  });

  blocTest<NowPlayingTVBloc, NowPlayingTVState>(
    'emits [NowPlayingTVError] when NowPlayingTVStarted is added but return error',
    build: () {
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => const Left(ServerFailure('error')));
      return nowPlayingTVBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTVStarted()),
    expect: () => [
      NowPlayingTVLoading(),
      const NowPlayingTVError('error'),
    ],
  );

  blocTest<NowPlayingTVBloc, NowPlayingTVState>(
    'emits [NowPlayingTVEmpty] when NowPlayingTVStarted is added but empty',
    build: () {
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingTVBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTVStarted()),
    expect: () => [
      NowPlayingTVLoading(),
      NowPlayingTVEmpty(),
    ],
  );

  blocTest<NowPlayingTVBloc, NowPlayingTVState>(
    'emits [NowPlayingTVSuccess] when NowPlayingTVStarted is added.',
    build: () {
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Right([testTV]));
      return nowPlayingTVBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTVStarted()),
    expect: () => [
      NowPlayingTVLoading(),
      NowPlayingTVSuccess([testTV]),
    ],
  );
}
