import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class GetWatchlistTV {
  final TVRepository _repository;

  GetWatchlistTV(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTV();
  }
}
