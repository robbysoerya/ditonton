import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watch_list_movies_page_test.mocks.dart';

@GenerateMocks([
  WatchListMoviesBloc,
  MovieDetailBloc,
], customMocks: [
  MockSpec<NavigatorObserver>(
    as: #MockNavigatorObserver,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockWatchListMoviesBloc mockNotifier;
  late MockMovieDetailBloc mockMovieDetailNotifier;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNotifier = MockWatchListMoviesBloc();
    mockMovieDetailNotifier = MockMovieDetailBloc();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  MaterialPageRoute movieDetailRoute(int id) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<MovieDetailBloc>.value(
              value: mockMovieDetailNotifier,
              child: MovieDetailPage(
                id: id,
              ),
            ),
        settings: RouteSettings(name: MOVIE_DETAIL_ROUTE, arguments: id));
  }

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchListMoviesBloc>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
        navigatorObservers: [mockNavigatorObserver],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case MOVIE_DETAIL_ROUTE:
              return movieDetailRoute(settings.arguments as int);
          }
          return null;
        },
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(WatchListMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(const WatchListMoviesSuccess(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state)
        .thenReturn(const WatchListMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should return Movie Card when Request State is Loaded',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(WatchListMoviesSuccess([testMovie]));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should navigate to Movie Detail when tap Movie Card',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockMovieDetailNotifier.stream)
        .thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(WatchListMoviesSuccess([testMovie]));
    when(mockMovieDetailNotifier.state).thenReturn(MovieDetailSuccess(
      movie: testMovieDetail,
      recommendations: [testMovie],
      isAddedWatchList: false,
    ));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    final movieCard = find.byType(MovieCard);
    await tester.tap(movieCard);
    await tester.pump();

    verify(mockNavigatorObserver.didPush(any, any));
    expect(find.byType(MovieDetailPage, skipOffstage: false), findsOneWidget);
  });
}
