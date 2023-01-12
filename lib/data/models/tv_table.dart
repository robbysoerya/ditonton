import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TVTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TVTable.fromEntity(TVDetail tv) => TVTable(
    id: tv.id,
    name: tv.name,
    posterPath: tv.posterPath,
    overview: tv.overview,
  );

  factory TVTable.fromMap(Map<String, dynamic> map) => TVTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  factory TVTable.fromDTO(TVModel movie) => TVTable(
    id: movie.id,
    name: movie.name,
    posterPath: movie.posterPath,
    overview: movie.overview,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  TV toEntity() => TV.watchList(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
