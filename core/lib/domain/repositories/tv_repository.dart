import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';
import 'package:dartz/dartz.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getOnTheAirTV();
  Future<Either<Failure, List<TV>>> getPopularTV();
  Future<Either<Failure, List<TV>>> getTopRatedTV();
  Future<Either<Failure, TVDetail>> getTVDetail(int id);
  Future<Either<Failure, List<TV>>> getTVRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTV(String query);
  Future<Either<Failure, String>> saveWatchlist(TVDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TVDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTV();
  Future<Either<Failure, TVSeasonsDetail>> getSeasonDetail(int id, int season);
}
