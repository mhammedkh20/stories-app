import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  int index = 0;

  MainCubit() : super(MainInitial());

  static MainCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  changeIndexBottomNav(int index) {
    this.index = index;
    emit(IndexBottomNav(index));
  }
}
