import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class GetTVRecommendations {
  final TVRepository repository;

  GetTVRecommendations(this.repository);

  Future<Either<Failure, List<TV>>> execute(id) {
    return repository.getTVRecommendations(id);
  }
}
