import 'package:equatable/equatable.dart';

import 'episodes.dart';

class TVSeasonsDetail extends Equatable{
  const TVSeasonsDetail({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String airDate;
  final List<Episodes> episodes;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;


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