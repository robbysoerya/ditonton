import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class GetTopRatedTV {
  final TVRepository repository;

  GetTopRatedTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTopRatedTV();
  }
}
