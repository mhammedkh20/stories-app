part of 'progress_loading_cubit.dart';

@immutable
abstract class ProgressLoadingState {}

class ProgressLoadingInitial extends ProgressLoadingState {}

class LoadingProgress extends ProgressLoadingState {}
