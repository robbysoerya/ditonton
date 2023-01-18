import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class GetTVDetail {
  final TVRepository repository;

  GetTVDetail(this.repository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getTVDetail(id);
  }
}
