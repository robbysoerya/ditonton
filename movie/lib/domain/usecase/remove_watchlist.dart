import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
