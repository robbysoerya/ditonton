part of 'popular_tv_bloc.dart';

abstract class PopularTVState extends Equatable {
  const PopularTVState();

  @override
  List<Object> get props => [];
}

class PopularTVLoading extends PopularTVState {}

class PopularTVEmpty extends PopularTVState {}

class PopularTVError extends PopularTVState {
  final String message;

  const PopularTVError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTVSuccess extends PopularTVState {
  final List<TV> tv;

  const PopularTVSuccess(this.tv);

  @override
  List<Object> get props => [tv];
}
