import 'package:core/core.dart';

const testLastEpisodeToAir = LastEpisodeToAir(
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

const testLastEpisodeToAirModel = LastEpisodeToAirModel(
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

const testSeason = Seasons(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
);

const testSeasonModel = SeasonsModel(
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
  genreIds: const [14, 28],
  id: 557,
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 7.2,
  voteCount: 13507,
);

final tesTVList = [testTV];

const testTVDetail = TVDetail(
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

const testTVDetailResponse = TVDetailResponse(
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
  'genres': [const GenreModel(id: 1, name: 'name').toJson()],
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

const testTVTable = TVTable(
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

const testTVSeasonEpisode = Episodes(
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

const testTVSeasonEpisodeModel = EpisodesModel(
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

const testTVSeasonDetail = TVSeasonsDetail(
    id: 1,
    airDate: 'airDate',
    episodes: [testTVSeasonEpisode],
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
);

const testTVSeasonDetailModel = TvSeasonsDetailModel(
    id: 1,
    airDate: 'airDate',
    episodes: [testTVSeasonEpisodeModel],
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
);


