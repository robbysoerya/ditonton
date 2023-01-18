import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class RemoveWatchlistTV {
  final TVRepository repository;

  RemoveWatchlistTV(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
