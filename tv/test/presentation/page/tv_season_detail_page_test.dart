import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvSeasonDetailBloc])
void main() {
  late MockTvSeasonDetailBloc mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeasonDetailBloc();
  });

  MaterialPageRoute tvSeasonDetailRoute(TVSeasonDetailArgs args) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<TvSeasonDetailBloc>.value(
              value: mockNotifier,
              child: TVSeasonDetailPage(
                args: args,
              ),
            ),
        settings: RouteSettings(
          name: TV_SEASON_DETAIL_ROUTE,
          arguments: args,
        ));
  }

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeasonDetailBloc>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case TV_SEASON_DETAIL_ROUTE:
              return tvSeasonDetailRoute(
                  settings.arguments as TVSeasonDetailArgs);
          }
          return null;
        },
      ),
    );
  }

  const args = TVSeasonDetailArgs(id: 1, season: 1);

  testWidgets(
      'should return CircularProgressIndicator when tv season detail state is Loading',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(TvSeasonDetailLoading());

    await tester
        .pumpWidget(makeTestableWidget(const TVSeasonDetailPage(args: args)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should return Text error when tv season detail state is error',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(const TvSeasonDetailError('Failed'));

    await tester
        .pumpWidget(makeTestableWidget(const TVSeasonDetailPage(args: args)));
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'should return ContentWidget when tv season detail state is loaded ',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    //arrange
    when(mockNotifier.state).thenReturn(const TvSeasonDetailSuccess(testTVSeasonDetail));
    //act
    await tester
        .pumpWidget(makeTestableWidget(const TVSeasonDetailPage(args: args)));
    //assert
    expect(find.byType(ContentWidget), findsOneWidget);
  });
}
