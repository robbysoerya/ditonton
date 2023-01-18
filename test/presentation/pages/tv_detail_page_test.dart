import '../../../core/lib/common/constants.dart';
import '../../../core/lib/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_season_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([
  TVDetailNotifier,
  TVSeasonDetailNotifier
], customMocks: [
  MockSpec<NavigatorObserver>(
    as: #MockNavigatorObserver,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockTVDetailNotifier mockNotifier;
  late MockTVSeasonDetailNotifier mockTVSeasonDetailNotifier;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockNotifier = MockTVDetailNotifier();
    mockTVSeasonDetailNotifier = MockTVSeasonDetailNotifier();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  MaterialPageRoute tvDetailRoute(int id) {
    return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<TVDetailNotifier>.value(
              value: mockNotifier,
              child: TVDetailPage(
                id: id,
              ),
            ),
        settings: RouteSettings(name: TVDetailPage.ROUTE_NAME, arguments: id));
  }

  MaterialPageRoute tvSeasonDetailRoute(TVSeasonDetailArgs args) {
    return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<TVSeasonDetailNotifier>.value(
              value: mockTVSeasonDetailNotifier,
              child: TVSeasonDetailPage(
                args: args,
              ),
            ),
        settings: RouteSettings(
          name: TVSeasonDetailPage.ROUTE_NAME,
          arguments: args,
        ));
  }

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVDetailNotifier>.value(
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
            case TVDetailPage.ROUTE_NAME:
              return tvDetailRoute(settings.arguments as int);
            case TVSeasonDetailPage.ROUTE_NAME:
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
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'should return CircularProgressIndicator when movie state is Loading',
      (tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loading);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should return Text error when movie state is error',
      (tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Failed');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'should action to be removeFromWatchList when isAddedWatchlist is false',
      (tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'should return CircularProgressIndicator when movie recommendation state is Loading',
      (tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loading);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('should navigate to TV Season Detail when tap tv seasons',
      (tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[testTV]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');
    when(mockTVSeasonDetailNotifier.state).thenReturn(RequestState.loaded);
    when(mockTVSeasonDetailNotifier.tvSeasons).thenReturn(testTVSeasonDetail);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    final inkwellButton = find.byKey(Key('tv-seasons-1'));
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

  testWidgets('should return Text error when tv recommendation state is error',
      (tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.error);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockNotifier.message).thenReturn('Failed');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('should navigate to TV Detail when tap tv recommendation',
      (tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[testTV]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    final inkwellButton = find.byKey(Key('tv-rec-557'));
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
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[testTV]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

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
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[testTV]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.text('14m'), findsOneWidget);
  });

  testWidgets('should return hour when duration greater than 1 hour',
      (tester) async {
    final tTVDetail = TVDetail(
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

    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(tTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<TV>[testTV]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.text('1h 0m'), findsOneWidget);
  });

  testWidgets(
      'should not return Container when movie recommendation state is empty',
      (tester) async {
    when(mockNotifier.tvDetailState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvDetail).thenReturn(testTVDetail);
    when(mockNotifier.tvRecommendationsState).thenReturn(RequestState.empty);
    when(mockNotifier.tvRecommendations).thenReturn([]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(Container), findsWidgets);
  });
}
