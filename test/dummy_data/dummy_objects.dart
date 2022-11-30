import 'package:ditonton/data/models/episodes_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/last_episode_to_air_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/seasons_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_seasons_detail_model.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/episodes.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/seasons.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_seasons_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};


final testLastEpisodeToAir = LastEpisodeToAir(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
);

final testLastEpisodeToAirModel = LastEpisodeToAirModel(
  airDate: 'airDate',
  episodeNumber: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  productionCode: 'productionCode',
  seasonNumber: 1,
  showId: 1,
  stillPath: 'stillPath',
  voteAverage: 1,
  voteCount: 1,
);

final testSeason = Seasons(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
);

final testSeasonModel = SeasonsModel(
  airDate: 'airDate',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

final testTV = TV(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTVDetail = TVDetail(
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: [14],
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

final testTVDetailResponse = TVDetailResponse(
  adult: false,
  backdropPath: 'backdropPath',
  episodeRunTime: [14],
  firstAirDate: 'firstAirDate',
  genres: [GenreModel(id: 1, name: 'name')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  lastAirDate: 'lastAirDate',
  lastEpisodeToAir: testLastEpisodeToAirModel,
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ['en'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  seasons: [testSeasonModel],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
);

final testTVDetailMap = {
  "adult": false,
  "backdrop_path": 'backdropPath',
  "episode_run_time": [14],
  "first_air_date": 'firstAirDate',
  'genres': [GenreModel(id: 1, name: 'name').toJson()],
  'homepage': 'homepage',
  'id': 1,
  'in_production': false,
  'last_air_date': 'lastAirDate',
  'last_episode_to_air': testLastEpisodeToAirModel.toJson(),
  'name': 'name',
  'number_of_episodes': 1,
  'number_of_seasons': 1,
  'origin_country': ['en'],
  'original_language': 'originalLanguage',
  'original_name': 'originalName',
  'overview': 'overview',
  'popularity': 1,
  'poster_path': 'posterPath',
  'seasons': [testSeasonModel.toJson()],
  'status': 'status',
  'tagline': 'tagline',
  'type': 'type',
  'vote_average': 1,
  'vote_count': 1,
};

final testWatchlistTV = TV.watchList(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTVSeasonEpisode = Episodes(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    runtime: 20,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
);

final testTVSeasonEpisodeModel = EpisodesModel(
  airDate: 'airDate',
  episodeNumber: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  productionCode: 'productionCode',
  runtime: 20,
  seasonNumber: 1,
  showId: 1,
  stillPath: 'stillPath',
  voteAverage: 1,
  voteCount: 1,
);

final testTVSeasonDetail = TVSeasonsDetail(
    id: 1,
    airDate: 'airDate',
    episodes: [testTVSeasonEpisode],
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
);

final testTVSeasonDetailModel = TvSeasonsDetailModel(
    id: 1,
    airDate: 'airDate',
    episodes: [testTVSeasonEpisodeModel],
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
);


