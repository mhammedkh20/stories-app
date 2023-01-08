import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/widgets/my_text.dart';

class MyItemCardShareFriend extends StatelessWidget {
  final String text;
  final String value;
  const MyItemCardShareFriend({required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: AppColors.BLACK.withOpacity(.16),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              title: text,
              color: AppColors.BASE_COLOR,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            MyText(
              title: value,
              textOverflow: true,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
