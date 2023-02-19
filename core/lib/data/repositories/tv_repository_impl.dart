import 'dart:io';

import 'package:core/data/data.dart';
import 'package:core/domain/domain.dart';
import 'package:core/utils/utils.dart';
import 'package:dartz/dartz.dart';

class TVRepositoryImpl implements TVRepository {
  final TVRemoteDataSource remoteDataSource;
  final TVLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const TVRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TV>>> getOnTheAirTV() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getOnTheAirTV();
        localDataSource.cacheOnTheAirTV(
            result.map((tvList) => TVTable.fromDTO(tvList)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      } on SocketException catch (e) {
        return Left(ConnectionFailure(e.message));
      } on TlsException catch (e) {
        return Left(SSLFailure(e.message));
      }
    } else {
      try {
        final result = await localDataSource.getCachedOnTheAirTV();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getPopularTV() async {
    try {
      final result = await remoteDataSource.getPopularTV();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TVDetail>> getTVDetail(int id) async {
    try {
      final result = await remoteDataSource.getTVDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTVRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTVRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTopRatedTV() async {
    try {
      final result = await remoteDataSource.getTopRatedTV();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getWatchlistTV() async {
    try {
      final result = await localDataSource.getWatchlistTV();
      return Right(result.map((data) => data.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTVById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TVDetail tv) async {
    try {
      final result =
          await localDataSource.removeWatchlist(TVTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TVDetail tv) async {
    try {
      final result =
          await localDataSource.insertWatchlist(TVTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<TV>>> searchTV(String query) async {
    try {
      final result = await remoteDataSource.searchTV(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TVSeasonsDetail>> getSeasonDetail(
      int id, int season) async {
    try {
      final result = await remoteDataSource.getSeasonDetail(id, season);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SSLFailure(e.message));
    }
  }
}
