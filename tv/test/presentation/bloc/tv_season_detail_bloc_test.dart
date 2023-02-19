import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_season_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVSeasonDetail,
])
void main() {
  late TvSeasonDetailBloc tvSeasonDetailBloc;
  late MockGetTVSeasonDetail mockGetTVSeasonDetail;

  setUp(() {
    mockGetTVSeasonDetail = MockGetTVSeasonDetail();

    tvSeasonDetailBloc = TvSeasonDetailBloc(
      mockGetTVSeasonDetail,
    );
  });

  test('initial state should be [TvSeasonDetailLoading]', () {
    expect(tvSeasonDetailBloc.state, TvSeasonDetailLoading());
  });

  int tId = 1;
  int tSeasonId = 1;

  void arrangeUsecase() {
    when(mockGetTVSeasonDetail.execute(tId, tSeasonId))
        .thenAnswer((_) async => const Right(testTVSeasonDetail));
  }

  blocTest<TvSeasonDetailBloc, TvSeasonDetailState>(
    'emits [TVSeasonDetailError] when unsuccessfull',
    build: () {
      arrangeUsecase();
      when(mockGetTVSeasonDetail.execute(tId,tSeasonId)).thenAnswer(
        (_) async => const Left(ServerFailure('error')),
      );
      return tvSeasonDetailBloc;
    },
    act: (bloc) => bloc.add(TvSeasonDetailStarted(id: tId,season: tSeasonId)),
    expect: () => [
      TvSeasonDetailLoading(),
      const TvSeasonDetailError('error'),
    ],
  );

  blocTest<TvSeasonDetailBloc, TvSeasonDetailState>(
    'emits [TVSeasonDetailSuccess] when successfull',
    build: () {
      arrangeUsecase();
      when(mockGetTVSeasonDetail.execute(tId,tSeasonId)).thenAnswer(
        (_) async => const Right(testTVSeasonDetail),
      );
      return tvSeasonDetailBloc;
    },
    act: (bloc) => bloc.add(TvSeasonDetailStarted(id: tId,season: tSeasonId)),
    expect: () => [
      TvSeasonDetailLoading(),
      const TvSeasonDetailSuccess(testTVSeasonDetail),
    ],
  );

}
