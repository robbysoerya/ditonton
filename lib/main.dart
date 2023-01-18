import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSeasonDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingTVNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Material(
          child: CustomDrawer(
            content: HomeMoviePage(),
          ),
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case TV_ROUTE:
              return MaterialPageRoute(builder: (_) => TVSeriesPage());
            case TV_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                    create: (_) => di.locator<TVDetailNotifier>(),
                    child: TVDetailPage(id: id)),
              );
            case POPULAR_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TV_SEASON_DETAIL_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => TVSeasonDetailPage(
                        args: settings.arguments as TVSeasonDetailArgs,
                      ));
            case TOP_RATED_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case SEARCH_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchTVPage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case NOW_PLAYING_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => NowPlayingMoviesPage());
            case NOW_PLAYING_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => NowPlayingTVPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                  create: (_) => di.locator<MovieDetailNotifier>(),
                  child: MovieDetailPage(id: id),
                ),
                settings: settings,
              );
            case SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WATCHLIST_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WATCHLIST_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistTVPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
