import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';
import 'package:dartz/dartz.dart';

class GetOnTheAirTV {
  final TVRepository repository;

  GetOnTheAirTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getOnTheAirTV();
  }
}
