part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {
  const TVDetailEvent();

  @override
  List<Object> get props => [];
}

class TVDetailStarted extends TVDetailEvent {
  final int id;

  const TVDetailStarted(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddWatchList extends TVDetailEvent {
  final TVDetail tv;

  const OnAddWatchList(this.tv);

  @override
  List<Object> get props => [tv];
}

class OnRemoveWatchList extends TVDetailEvent {
  final TVDetail tv;

  const OnRemoveWatchList(this.tv);

  @override
  List<Object> get props => [tv];
}

class OnLoadWatchListStatus extends TVDetailEvent {
  final int id;

  const OnLoadWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
