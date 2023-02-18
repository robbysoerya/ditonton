import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([
  PopularTVBloc,
  TVDetailBloc
], customMocks: [
  MockSpec<NavigatorObserver>(
    as: #MockNavigatorObserver,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockPopularTVBloc mockNotifier;
  late MockTVDetailBloc mockTVDetailNotifier;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNotifier = MockPopularTVBloc();
    mockTVDetailNotifier = MockTVDetailBloc();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  MaterialPageRoute tvDetailRoute(int id) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<TVDetailBloc>(
              create: (context) => mockTVDetailNotifier,
              child: TVDetailPage(
                id: id,
              ),
            ),
        settings: RouteSettings(name: TV_DETAIL_ROUTE, arguments: id));
  }

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVBloc>(
      create: (context) => mockNotifier,
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
            case TV_DETAIL_ROUTE:
              return tvDetailRoute(settings.arguments as int);
          }
          return null;
        },
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(PopularTVLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(const PopularTVSuccess(<TV>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(const PopularTVError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should return TV Card when Request State is Loaded',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(PopularTVSuccess([testTV]));

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(find.byType(TVCard), findsOneWidget);
  });

  testWidgets('should navigate to TV Detail when tap TV Card', (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockTVDetailNotifier.stream)
        .thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(PopularTVSuccess([testTV]));
    when(mockTVDetailNotifier.state).thenReturn(
      TVDetailSuccess(
        tv: testTVDetail,
        recommendations: [testTV],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    final tvCard = find.byType(TVCard);
    await tester.tap(tvCard);
    await tester.pump();

    verify(mockNavigatorObserver.didPush(any, any));
    expect(find.byType(TVDetailPage, skipOffstage: false), findsOneWidget);
  });
}
