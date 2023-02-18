import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([
  PopularMoviesBloc,
  MovieDetailBloc,
], customMocks: [
  MockSpec<NavigatorObserver>(
    as: #MockNavigatorObserver,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockPopularMoviesBloc mockNotifier;
  late MockMovieDetailBloc mockMovieDetailNotifier;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNotifier = MockPopularMoviesBloc();
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
    return BlocProvider<PopularMoviesBloc>.value(
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
    when(mockNotifier.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(const PopularMoviesSuccess(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state)
        .thenReturn(const PopularMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should return Movie Card when Request State is Loaded',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(PopularMoviesSuccess([testMovie]));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should navigate to Movie Detail when tap Movie Card',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockMovieDetailNotifier.stream)
        .thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(PopularMoviesSuccess([testMovie]));
    when(mockMovieDetailNotifier.state).thenReturn(MovieDetailSuccess(
      movie: testMovieDetail,
      recommendations: [testMovie],
      isAddedWatchList: false,
    ));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    final movieCard = find.byType(MovieCard);
    await tester.tap(movieCard);
    await tester.pump();

    verify(mockNavigatorObserver.didPush(any, any));
    expect(find.byType(MovieDetailPage, skipOffstage: false), findsOneWidget);
  });
}
