part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTVState extends Equatable {
  const NowPlayingTVState();

  @override
  List<Object> get props => [];
}

class NowPlayingTVLoading extends NowPlayingTVState {}

class NowPlayingTVEmpty extends NowPlayingTVState {}

class NowPlayingTVError extends NowPlayingTVState {
  final String message;

  const NowPlayingTVError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTVSuccess extends NowPlayingTVState {
  final List<TV> tv;

  const NowPlayingTVSuccess(this.tv);

  @override
  List<Object> get props => [tv];
}
