import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';

class EpisodesModel extends Equatable{
  const EpisodesModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) =>
      EpisodesModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"] ?? 0,
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['air_date'] = airDate;
    map['episode_number'] = episodeNumber;
    map['id'] = id;
    map['name'] = name;
    map['overview'] = overview;
    map['production_code'] = productionCode;
    map['runtime'] = runtime;
    map['season_number'] = seasonNumber;
    map['show_id'] = showId;
    map['still_path'] = stillPath;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }

  Episodes toEntity() {
    return Episodes(
        airDate: airDate,
        episodeNumber: episodeNumber,
        id: id,
        name: name,
        overview: overview,
        productionCode: productionCode,
        runtime: runtime,
        seasonNumber: seasonNumber,
        showId: showId,
        stillPath: stillPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
    airDate,
    episodeNumber,
    id,
    name,
    overview,
    productionCode,
    runtime,
    seasonNumber,
    showId,
    stillPath,
    voteAverage,
    voteCount,
  ];

}