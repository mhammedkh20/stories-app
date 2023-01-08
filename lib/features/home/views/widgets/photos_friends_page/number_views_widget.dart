import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';

class NumberViewsWidget extends StatelessWidget {
  final int numberViews;

  const NumberViewsWidget({required this.numberViews});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 8.r,
      start: 16.r,
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.symmetric(
          horizontal: 8.r,
          vertical: 4.r,
        ),
        decoration: BoxDecoration(
          color: AppColors.WHITE.withOpacity(.4),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.GRAY.withOpacity(.5),
          ),
        ),
        child: MyText(title: numberViews.toString()),
      ),
    );
  }
}
