import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'pixels_scroll_controller_state.dart';

class PixelsScrollControllerCubit extends Cubit<PixelsScrollControllerState> {
  double pixels = 1;

  PixelsScrollControllerCubit() : super(PixelsScrollControllerInitial());

  static PixelsScrollControllerCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  void fillAppBar() {
    this.pixels = 1;
    emit(ScrollPageController());
  }

  void scrollingScreen(double pixels) {
    if (pixels <= 0) {
      this.pixels = 1;
      emit(ScrollPageController());
      return;
    }

    if (pixels > 400) {
      this.pixels = 0;
      emit(ScrollPageController());
      return;
    }

    this.pixels = 1 - pixels / 400;
    emit(ScrollPageController());
  }
}
