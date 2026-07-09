part of 'info_cubit.dart';

abstract class InfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InfoInitial extends InfoState {}

class InfoLoading extends InfoState {}

class InfoLoaded extends InfoState {
  final AppInfo info;
  InfoLoaded(this.info);
  @override
  List<Object?> get props => [info];
}

class InfoError extends InfoState {}
