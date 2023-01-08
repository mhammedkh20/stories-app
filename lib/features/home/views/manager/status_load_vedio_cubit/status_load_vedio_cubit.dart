// ignore_for_file: constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'status_load_vedio_state.dart';

class StatusLoadVedioCubit extends Cubit<StatusLoadVedioState> {
  static const LOADING = 'loading';
  static const FAILURE = 'failure';
  static const SUCCESS = 'success';

  String status = LOADING;

  StatusLoadVedioCubit() : super(StatusLoadVedioInitial());

  static StatusLoadVedioCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  changeLoadVedio(String status) {
    this.status = status;
    emit(StatusItemVedio());
  }
}
