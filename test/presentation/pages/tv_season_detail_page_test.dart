
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv_season_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_season_detail_page_test.mocks.dart';

@GenerateMocks([TVSeasonDetailNotifier])

void main() {
  late MockTVSeasonDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTVSeasonDetailNotifier();
  });

  MaterialPageRoute tvSeasonDetailRoute(TVSeasonDetailArgs args) {
    return MaterialPageRoute(builder: (_) =>
    ChangeNotifierProvider<TVSeasonDetailNotifier>.value(
      value: mockNotifier,
      child: TVSeasonDetailPage(args: args,
      ),
    ),
        settings: RouteSettings(
            name: TVSeasonDetailPage.ROUTE_NAME,
            arguments: args,
        )
    );
  }

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVSeasonDetailNotifier>.value(
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
          switch(settings.name) {
            case TVSeasonDetailPage.ROUTE_NAME:
              return tvSeasonDetailRoute(settings.arguments as TVSeasonDetailArgs);
          }
        },
      ),
    );
  }

  final args = TVSeasonDetailArgs(id: 1, season: 1);

  testWidgets(
      'should return CircularProgressIndicator when tv season detail state is Loading', (
      tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(TVSeasonDetailPage(args: args)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should return Text error when tv season detail state is error', (tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Failed');

    await tester.pumpWidget(_makeTestableWidget(TVSeasonDetailPage(args: args)));
    expect(find.text('Failed'), findsOneWidget);
  });
  
  testWidgets('should return ContentWidget when tv season detail state is loaded ', (tester) async {
    //arrange
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeasons).thenReturn(testTVSeasonDetail);
    //act
    await tester.pumpWidget(_makeTestableWidget(TVSeasonDetailPage(args: args)));
    //assert
    expect(find.byType(ContentWidget), findsOneWidget);
  });
}
