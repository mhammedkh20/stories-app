part of 'main_cubit.dart';

abstract class MainState {}

class MainInitial extends MainState {}

class IndexBottomNav extends MainState {
  final int index;
  IndexBottomNav(this.index);
}
