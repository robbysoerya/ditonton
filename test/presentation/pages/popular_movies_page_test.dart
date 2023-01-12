import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([
  PopularMoviesNotifier,
  MovieDetailNotifier
], customMocks: [
  MockSpec<NavigatorObserver>(
    as: #MockNavigatorObserver,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockPopularMoviesNotifier mockNotifier;
  late MockMovieDetailNotifier mockMovieDetailNotifier;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNotifier = MockPopularMoviesNotifier();
    mockMovieDetailNotifier = MockMovieDetailNotifier();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  MaterialPageRoute movieDetailRoute(int id) {
    return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<MovieDetailNotifier>.value(
              value: mockMovieDetailNotifier,
              child: MovieDetailPage(
                id: id,
              ),
            ),
        settings:
            RouteSettings(name: MovieDetailPage.ROUTE_NAME, arguments: id));
  }

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularMoviesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
        navigatorObservers: [mockNavigatorObserver],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case MovieDetailPage.ROUTE_NAME:
              return movieDetailRoute(settings.arguments as int);
          }
          return null;
        },
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should return Movie Card when Request State is Loaded',
      (tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.movies).thenReturn([testMovie]);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should navigate to Movie Detail when tap Movie Card',
      (tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.movies).thenReturn([testMovie]);
    when(mockMovieDetailNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockMovieDetailNotifier.movie).thenReturn(testMovieDetail);
    when(mockMovieDetailNotifier.recommendationState)
        .thenReturn(RequestState.loaded);
    when(mockMovieDetailNotifier.movieRecommendations).thenReturn([testMovie]);
    when(mockMovieDetailNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    final movieCard = find.byType(MovieCard);
    await tester.tap(movieCard);
    await tester.pump();

    verify(mockNavigatorObserver.didPush(any, any));
    expect(find.byType(MovieDetailPage, skipOffstage: false), findsOneWidget);
  });
}
