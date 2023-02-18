import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([
  TVDetailBloc,
  TvSeasonDetailBloc
], customMocks: [
  MockSpec<NavigatorObserver>(
    as: #MockNavigatorObserver,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockTVDetailBloc mockNotifier;
  late MockTvSeasonDetailBloc mockTVSeasonDetailNotifier;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNotifier = MockTVDetailBloc();
    mockTVSeasonDetailNotifier = MockTvSeasonDetailBloc();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  MaterialPageRoute tvDetailRoute(int id) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<TVDetailBloc>.value(
              value: mockNotifier,
              child: TVDetailPage(
                id: id,
              ),
            ),
        settings: RouteSettings(name: TV_DETAIL_ROUTE, arguments: id));
  }

  MaterialPageRoute tvSeasonDetailRoute(TVSeasonDetailArgs args) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<TvSeasonDetailBloc>.value(
              value: mockTVSeasonDetailNotifier,
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
    return BlocProvider<TVDetailBloc>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
        navigatorObservers: [mockNavigatorObserver],
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case TV_DETAIL_ROUTE:
              return tvDetailRoute(settings.arguments as int);
            case TV_SEASON_DETAIL_ROUTE:
              return tvSeasonDetailRoute(
                  settings.arguments as TVSeasonDetailArgs);
          }
          return null;
        },
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(
      const TVDetailSuccess(
        tv: testTVDetail,
        recommendations: <TV>[],
        isAddedWatchList: false,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(
      const TVDetailSuccess(
        tv: testTVDetail,
        recommendations: <TV>[],
        isAddedWatchList: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
  //   when(mockNotifier.state).thenReturn(
  //     const TVDetailSuccess(
  //       tv: testTVDetail,
  //       recommendations: <TV>[],
  //       isAddedWatchList: false,
  //     ),
  //   );

  //   final watchlistButton = find.byIcon(Icons.add);

  //   await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   // expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  testWidgets(
      'should return CircularProgressIndicator when movie state is Loading',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(TVDetailLoading());

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should return Text error when movie state is error',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(const TVDetailError('Failed'));

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));
    expect(find.text('Failed'), findsOneWidget);
  });

  // testWidgets(
  //     'should action to be removeFromWatchList when isAddedWatchlist is false',
  //     (tester) async {
  //   when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
  //   when(mockNotifier.state).thenReturn(
  //     const TVDetailSuccess(
  //       tv: testTVDetail,
  //       recommendations: <TV>[],
  //       isAddedWatchList: true,
  //     ),
  //   );
  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

  //   await tester.tap(watchlistButton);

  //   await tester.pump();

  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  testWidgets('should navigate to TV Season Detail when tap tv seasons',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockTVSeasonDetailNotifier.stream)
        .thenAnswer((_) => Stream.fromIterable([]));
    when(mockTVSeasonDetailNotifier.state)
        .thenReturn(const TvSeasonDetailSuccess(testTVSeasonDetail));
    when(mockNotifier.state).thenReturn(
      TVDetailSuccess(
        tv: testTVDetail,
        recommendations: <TV>[testTV],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    final inkwellButton = find.byKey(const Key('tv-seasons-1'));
    await tester.ensureVisible(inkwellButton);
    await tester.tap(inkwellButton);
    await tester.pump();

    verify(mockNavigatorObserver.didPush(
      any,
      any,
    ));

    expect(
        find.byType(TVSeasonDetailPage, skipOffstage: false), findsOneWidget);
  });

  testWidgets('should navigate to TV Detail when tap tv recommendation',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(
      TVDetailSuccess(
        tv: testTVDetail,
        recommendations: <TV>[testTV],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    final inkwellButton = find.byKey(const Key('tv-rec-557'));
    await tester.ensureVisible(inkwellButton);
    await tester.tap(inkwellButton);
    await tester.pump();

    verify(mockNavigatorObserver.didPush(
      any,
      any,
    ));

    expect(find.byType(TVDetailPage), findsOneWidget);
  });

  testWidgets('should pop when tap icon arrow back', (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(
      const TVDetailSuccess(
        tv: testTVDetail,
        recommendations: <TV>[],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    final iconButton = find.byType(IconButton);

    await tester.tap(iconButton);
    await tester.pump();

    verify(mockNavigatorObserver.didPop(
      any,
      any,
    ));

    expect(find.byType(TVDetailPage), findsOneWidget);
  });

  testWidgets('should return minute when duration less than 1 hour',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(
      TVDetailSuccess(
        tv: testTVDetail,
        recommendations: <TV>[testTV],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.text('14m'), findsOneWidget);
  });

  testWidgets('should return hour when duration greater than 1 hour',
      (tester) async {
    const tTVDetail = TVDetail(
      adult: false,
      backdropPath: 'backdropPath',
      episodeRunTime: [60],
      firstAirDate: 'firstAirDate',
      genres: [Genre(id: 1, name: 'name')],
      homepage: 'homepage',
      id: 1,
      inProduction: false,
      lastAirDate: 'lastAirDate',
      lastEpisodeToAir: testLastEpisodeToAir,
      name: 'name',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['en'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      seasons: [testSeason],
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 1,
      voteCount: 1,
    );

    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(
      const TVDetailSuccess(
        tv: tTVDetail,
        recommendations: <TV>[],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.text('1h 0m'), findsOneWidget);
  });

  testWidgets(
      'should not return Container when movie recommendation state is empty',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(
      const TVDetailSuccess(
        tv: testTVDetail,
        recommendations: <TV>[],
        isAddedWatchList: false,
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(Container), findsWidgets);
  });
}
