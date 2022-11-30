import 'package:ditonton/domain/entities/tv_seasons_detail.dart';
import 'package:equatable/equatable.dart';

import 'episodes_model.dart';

class TvSeasonsDetailModel extends Equatable{
  TvSeasonsDetailModel({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory TvSeasonsDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeasonsDetailModel(
        id: json["id"],
        airDate: json["air_date"],
        episodes: List<EpisodesModel>.from(json["episodes"].map((x) => EpisodesModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"] == null ? '' : json["poster_path"],
        seasonNumber: json["season_number"],
      );

  final String airDate;
  final List<EpisodesModel> episodes;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['air_date'] = airDate;
    map['episodes'] = episodes.map((v) => v.toJson()).toList();
    map['name'] = name;
    map['overview'] = overview;
    map['id'] = id;
    map['poster_path'] = posterPath;
    map['season_number'] = seasonNumber;
    return map;
  }

  TVSeasonsDetail toEntity() {
    return TVSeasonsDetail(id: id,
        airDate: airDate,
        episodes: episodes.map((e) => e.toEntity()).toList(),
        name: name,
        overview: overview,
        posterPath: posterPath,
        seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
    id,
    airDate,
    episodes,
    name,
    overview,
    posterPath,
    seasonNumber,
  ];
}