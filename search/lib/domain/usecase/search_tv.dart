import 'package:dartz/dartz.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';

class SearchTV {
  final TVRepository repository;

  SearchTV(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTV(query);
  }
}
