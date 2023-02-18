part of 'watch_list_tv_bloc.dart';

abstract class WatchListTVState extends Equatable {
  const WatchListTVState();

  @override
  List<Object> get props => [];
}

class WatchListTVLoading extends WatchListTVState {}

class WatchListTVEmpty extends WatchListTVState {}

class WatchListTVError extends WatchListTVState {
  final String message;

  const WatchListTVError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchListTVSuccess extends WatchListTVState {
  final List<TV> tv;

  const WatchListTVSuccess(this.tv);

  @override
  List<Object> get props => [tv];
}
