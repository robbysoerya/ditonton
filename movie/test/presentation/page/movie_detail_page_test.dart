import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([
  MovieDetailBloc,
  BuildContext
], customMocks: [
  MockSpec<NavigatorObserver>(
    as: #MockNavigatorObserver,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockMovieDetailBloc mockNotifier;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNotifier = MockMovieDetailBloc();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  MaterialPageRoute movieDetailRoute(int id) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<MovieDetailBloc>.value(
              value: mockNotifier,
              child: MovieDetailPage(
                id: id,
              ),
            ),
        settings: RouteSettings(name: MOVIE_DETAIL_ROUTE, arguments: id));
  }

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
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
          if (settings.name == MOVIE_DETAIL_ROUTE) {
            return movieDetailRoute(settings.arguments as int);
          }
          return null;
        },
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(
      const MovieDetailSuccess(
        movie: testMovieDetail,
        recommendations: <Movie>[],
        isAddedWatchList: false,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(
      const MovieDetailSuccess(
        movie: testMovieDetail,
        recommendations: <Movie>[],
        isAddedWatchList: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
  //   when(mockNotifier.state).thenReturn(
  //     const MovieDetailSuccess(
  //       movie: testMovieDetail,
  //       recommendations: <Movie>[],
  //       isAddedWatchList: false,
  //     ),
  //   );

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  testWidgets(
      'should return CircularProgressIndicator when movie state is Loading',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(MovieDetailLoading());

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should return Text error when movie state is error',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(const MovieDetailError('Failed'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'should return error widget when CacheNetworkImage error to load url',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(
      const MovieDetailSuccess(
        movie: testMovieDetail,
        recommendations: <Movie>[],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // testWidgets(
  //     'should action to be removeFromWatchList when isAddedWatchlist is false',
  //     (tester) async {
  //   when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
  //   when(mockNotifier.state).thenReturn(
  //     const MovieDetailSuccess(
  //       movie: testMovieDetail,
  //       recommendations: <Movie>[],
  //       isAddedWatchList: true,
  //     ),
  //   );
  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

  //   await tester.tap(watchlistButton);

  //   await tester.pump();

  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  testWidgets('should navigate to Movie Detail when tap movie recommendation',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(MovieDetailSuccess(
      movie: testMovieDetail,
      recommendations: <Movie>[testMovie],
      isAddedWatchList: false,
    ));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    final inkwellButton = find.byKey(const Key('movie-rec-557'));
    await tester.ensureVisible(inkwellButton);
    await tester.tap(inkwellButton);
    await tester.pump();
    verify(mockNavigatorObserver.didPush(
      any,
      any,
    ));

    expect(find.byType(MovieDetailPage), findsOneWidget);
  });

  testWidgets('should pop when tap icon arrow back', (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(
      const MovieDetailSuccess(
        movie: testMovieDetail,
        recommendations: <Movie>[],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    final iconButton = find.byType(IconButton);

    await tester.tap(iconButton);
    await tester.pump();

    verify(mockNavigatorObserver.didPop(
      any,
      any,
    ));

    expect(find.byType(MovieDetailPage), findsOneWidget);
  });

  testWidgets('should return minute when duration less than 1 hour',
      (tester) async {
    const tMovieDetail = MovieDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [Genre(id: 1, name: 'Action')],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      runtime: 14,
      title: 'title',
      voteAverage: 1,
      voteCount: 1,
    );
    when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
    when(mockNotifier.state).thenReturn(
      const MovieDetailSuccess(
        movie: tMovieDetail,
        recommendations: <Movie>[],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.text('14m'), findsOneWidget);
  });

  // testWidgets(
  //     'should not return ListView when movie recommendation state is empty',
  //     (tester) async {
  //   when(mockNotifier.stream).thenAnswer((_) => (Stream.fromIterable([])));
  //   when(mockNotifier.state).thenReturn(
  //     const MovieDetailSuccess(
  //       movie: testMovieDetail,
  //       recommendations: [],
  //       isAddedWatchList: false,
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
  //   await tester.pump();

  //   expect(find.byType(ListView), findsNothing);
  // });
}
