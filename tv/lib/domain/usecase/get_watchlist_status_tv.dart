import 'package:core/domain/domain.dart';

class GetWatchListStatusTV {
  final TVRepository repository;

  GetWatchListStatusTV(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
