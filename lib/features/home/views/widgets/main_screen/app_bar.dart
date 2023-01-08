import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/views/manager/main_cubit/main_cubit.dart';
import 'package:stories_app/features/home/views/manager/pixels_scroll_controller/pixels_scroll_controller_cubit.dart';

class AppBarMainScreen extends StatelessWidget
    with PreferredSizeWidget, Helpers {
  const AppBarMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: BlocBuilder<PixelsScrollControllerCubit,
            PixelsScrollControllerState>(
          builder: (context, state) {
            return AppBar(
              backgroundColor: AppColors.BASE_COLOR
                  .withOpacity(PixelsScrollControllerCubit.get(context).pixels),
              centerTitle: true,
              title: getTitleScreen(context),
              actions: [
                // MyIconButtonYoutube(),
                IconButton(
                  onPressed: () {
                    ZoomDrawer.of(context)!.toggle();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: AppColors.WHITE,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getTitleScreen(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return MyText(
          title: getPage(context, (state is IndexBottomNav) ? state.index : 0)
              .name,
        );
      },
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 58.h);
}
