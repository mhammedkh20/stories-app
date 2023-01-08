import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'status_icon_favorite_state.dart';

class StatusIconFavoriteCubit extends Cubit<StatusIconFavoriteState> {
  StatusIconFavoriteCubit() : super(StatusIconFavoriteInitial());
  bool statusChange = false;

  static StatusIconFavoriteCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  changeStatus() {
    statusChange = !statusChange;
    emit(ChangeStatusIcon());
  }
}
