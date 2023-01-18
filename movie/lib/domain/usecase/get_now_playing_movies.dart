import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';
import 'package:dartz/dartz.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
