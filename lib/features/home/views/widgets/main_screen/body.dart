import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/features/home/views/manager/main_cubit/main_cubit.dart';

class BodyMainScreen extends StatelessWidget with Helpers {
  const BodyMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return getPage(context, (state is IndexBottomNav) ? state.index : 0)
            .widget;
      },
    );
  }
}
