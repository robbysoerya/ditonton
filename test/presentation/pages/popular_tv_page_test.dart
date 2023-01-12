import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([
  PopularTVNotifier,
  TVDetailNotifier
], customMocks: [
  MockSpec<NavigatorObserver>(
    as: #MockNavigatorObserver,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockPopularTVNotifier mockNotifier;
  late MockTVDetailNotifier mockTVDetailNotifier;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNotifier = MockPopularTVNotifier();
    mockTVDetailNotifier = MockTVDetailNotifier();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  MaterialPageRoute tvDetailRoute(int id) {
    return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<TVDetailNotifier>.value(
              value: mockTVDetailNotifier,
              child: TVDetailPage(
                id: id,
              ),
            ),
        settings: RouteSettings(name: TVDetailPage.ROUTE_NAME, arguments: id));
  }

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularTVNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        navigatorObservers: [mockNavigatorObserver],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case TVDetailPage.ROUTE_NAME:
              return tvDetailRoute(settings.arguments as int);
          }
          return null;
        },
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.popularTVState).thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.popularTVState).thenReturn(RequestState.loaded);
    when(mockNotifier.popularTV).thenReturn(<TV>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.popularTVState).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should return TV Card when Request State is Loaded',
      (tester) async {
    when(mockNotifier.popularTVState).thenReturn(RequestState.loaded);
    when(mockNotifier.popularTV).thenReturn([testTV]);

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(find.byType(TVCard), findsOneWidget);
  });

  testWidgets('should navigate to TV Detail when tap TV Card', (tester) async {
    when(mockNotifier.popularTVState).thenReturn(RequestState.loaded);
    when(mockNotifier.popularTV).thenReturn([testTV]);
    when(mockTVDetailNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockTVDetailNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockTVDetailNotifier.tvRecommendationsState)
        .thenReturn(RequestState.loaded);
    when(mockTVDetailNotifier.tvRecommendations).thenReturn([testTV]);
    when(mockTVDetailNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    final tvCard = find.byType(TVCard);
    await tester.tap(tvCard);
    await tester.pump();

    verify(mockNavigatorObserver.didPush(any, any));
    expect(find.byType(TVDetailPage, skipOffstage: false), findsOneWidget);
  });
}
