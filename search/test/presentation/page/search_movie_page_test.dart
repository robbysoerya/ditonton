import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockSearchBloc mockNotifier;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNotifier = MockSearchBloc();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchBloc>(
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
            case MOVIE_DETAIL_ROUTE:
              return MaterialPageRoute(builder: (_) => Container());
          }
          return null;
        },
      ),
    );
  }

  // testWidgets('Page should display center progress bar when loading',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
  //   when(mockNotifier.state).thenReturn(SearchLoading());

  //   final progressBarFinder = find.byType(CircularProgressIndicator);
  //   final centerFinder = find.byType(Center);

  //   await tester.pumpWidget(makeTestableWidget(const SearchPage()));

  //   expect(centerFinder, findsOneWidget);
  //   expect(progressBarFinder, findsOneWidget);
  // });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(const SearchHasData(result: <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state)
        .thenReturn(const SearchError(message: 'Error message'));

    final textFinder = find.text('Error message');

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should return Movie Card when Request State is Loaded',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(SearchHasData(result: testMovieList));

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should navigate to Movie Detail when tap Movie Card', (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(SearchHasData(result: testMovieList));

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    final tvCard = find.byType(MovieCard);
    await tester.tap(tvCard);
    await tester.pump();

    verify(mockNavigatorObserver.didPush(any, any));
  });
}
