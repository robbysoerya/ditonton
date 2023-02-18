part of 'tv_detail_bloc.dart';



abstract class TVDetailState extends Equatable {
  const TVDetailState();

  @override
  List<Object?> get props => [];
}

class TVDetailLoading extends TVDetailState {}

class TVDetailError extends TVDetailState {
  final String message;

  const TVDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TVDetailSuccess extends TVDetailState {
  final TVDetail tv;
  final List<TV> recommendations;
  final bool isAddedWatchList;
  final String? message;

  const TVDetailSuccess({
    required this.tv,
    required this.recommendations,
    required this.isAddedWatchList,
    this.message,
  });

  TVDetailSuccess copyWith({
    bool? isAddedWatchList,
    String? message,
  }) {
    return TVDetailSuccess(
      tv: tv,
      recommendations: recommendations,
      isAddedWatchList: isAddedWatchList ?? this.isAddedWatchList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        tv,
        recommendations,
        isAddedWatchList,
        message,
      ];
}
