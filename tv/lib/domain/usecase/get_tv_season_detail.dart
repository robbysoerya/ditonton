import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class GetTVSeasonDetail {
  final TVRepository repository;

  GetTVSeasonDetail(this.repository);

  Future<Either<Failure, TVSeasonsDetail>> execute(int id, int season) {
    return repository.getSeasonDetail(id, season);
  }
}
