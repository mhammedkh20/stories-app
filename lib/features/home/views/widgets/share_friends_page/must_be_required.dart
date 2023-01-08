import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';

class MustBeRequired extends StatelessWidget {
  final String title;
  final bool choice;
  const MustBeRequired(this.title, {this.choice = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                title: title,
                color: AppColors.BLACK.withOpacity(.8),
                fontSize: 14,
              ),
              MyText(
                title: choice ? 'اختياري' : '(اجباري)',
                color: AppColors.BLACK.withOpacity(.8),
                fontSize: 13,
              ),
            ],
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
