import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TVRepository,
  TVRemoteDataSource,
  TVLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
  NetworkClient,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
