import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_seasons_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTVSeasonDetail {
  final TVRepository repository;

  GetTVSeasonDetail(this.repository);

  Future<Either<Failure, TVSeasonsDetail>> execute(int id, int season) {
    return repository.getSeasonDetail(id,season);
  }
}
