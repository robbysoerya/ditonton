part of 'search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];
}

class SearchTVInitial extends SearchTvState {}

class SearchTVEmpty extends SearchTvState {}

class SearchTVLoading extends SearchTvState {}

class SearchTVError extends SearchTvState {
  final String message;

  const SearchTVError({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchTVHasData extends SearchTvState {
  final List<TV> result;

  const SearchTVHasData({required this.result});

  @override
  List<Object> get props => [result];
}
