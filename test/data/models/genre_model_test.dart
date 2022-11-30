import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(
    id: 1,
    name: "test",
  );

  final tGenre = Genre(
    id: 1,
    name: "test",
  );

  final tGenreMap = {
    "id": 1,
    "name": "test",
  };

  test('should be a subclass of Genre Entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('should be a Map of Genre', () async {
    final result = tGenreModel.toJson();
    expect(result, tGenreMap);
  });
}