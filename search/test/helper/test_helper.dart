import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:search/domain/domain.dart';
import 'package:search/presentation/presentation.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TVRepository,
  TVRemoteDataSource,
  TVLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
  NetworkClient,
  SearchMovies,
  SearchTV,
  SearchBloc,
  SearchTvBloc,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient),
  MockSpec<NavigatorObserver>(
    as: #MockNavigatorObserver,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {}
