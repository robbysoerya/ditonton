part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTVState extends Equatable {
  const TopRatedTVState();

  @override
  List<Object> get props => [];
}

class TopRatedTVLoading extends TopRatedTVState {}

class TopRatedTVEmpty extends TopRatedTVState {}

class TopRatedTVError extends TopRatedTVState {
  final String message;

  const TopRatedTVError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVSuccess extends TopRatedTVState {
  final List<TV> tv;

  const TopRatedTVSuccess(this.tv);

  @override
  List<Object> get props => [tv];
}
