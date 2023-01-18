import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class GetPopularTV {
  final TVRepository repository;

  GetPopularTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getPopularTV();
  }
}
