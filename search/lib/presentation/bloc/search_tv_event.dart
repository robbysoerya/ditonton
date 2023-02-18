part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();

  @override
  List<Object> get props => [];
}

class OnQueryTVChanged extends SearchTvEvent {
  final String query;

  const OnQueryTVChanged({required this.query});

  @override
  List<Object> get props => [query];
}
