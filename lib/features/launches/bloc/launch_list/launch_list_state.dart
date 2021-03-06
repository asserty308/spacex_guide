part of 'launch_list_bloc.dart';

abstract class LaunchListState {}
class LaunchListStateInitial extends LaunchListState {}
class LaunchListStateLoading extends LaunchListState {}

class LaunchListStateUpcomingLoaded extends LaunchListState {
  LaunchListStateUpcomingLoaded({
    this.scheduled, 
    this.nonScheduled
  });
  
  final List<LaunchModel>? scheduled, nonScheduled;
}

class LaunchListStatePreviousLoaded extends LaunchListState {
  LaunchListStatePreviousLoaded(this.launches);
  final List<LaunchModel>? launches;
}

class LaunchListStateError extends LaunchListState {}