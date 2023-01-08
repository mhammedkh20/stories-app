import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/features/home/views/manager/photo_friends_cubit/photo_friends_cubit.dart';
import 'package:stories_app/features/home/views/manager/status_icon_favorite/status_icon_favorite_cubit.dart';

class IconFavoriateWidgetAnimated extends StatelessWidget {
  final GestureTapCallback onTap;

  IconFavoriateWidgetAnimated({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 0,
      top: 0,
      child: Container(
        width: 50.r,
        alignment: Alignment.center,
        height: 40.r,
        child: Stack(
          children: [
            BlocBuilder<StatusIconFavoriteCubit, StatusIconFavoriteState>(
              builder: (context, state) {
                return AnimatedPositionedDirectional(
                  top: StatusIconFavoriteCubit.get(context).statusChange
                      ? -0
                      : 8.r,
                  start: 0,
                  end: 0,
                  duration: Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.RED,
                      size: StatusIconFavoriteCubit.get(context).statusChange
                          ? 30
                          : 24,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
