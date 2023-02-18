part of 'watch_list_tv_bloc.dart';

abstract class WatchListTVEvent extends Equatable {
  const WatchListTVEvent();

  @override
  List<Object> get props => [];
}

class WatchListTVStarted extends WatchListTVEvent {}
