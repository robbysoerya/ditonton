import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
