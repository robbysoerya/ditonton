import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class SaveWatchlistTV {
  final TVRepository repository;

  SaveWatchlistTV(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
