import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_elevated_button.dart';
import 'package:stories_app/core/widgets/my_text.dart';

class FabWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;

  const FabWidget({
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      end: 16.w,
      start: 16.w,
      bottom: 10.h,
      child: SizedBox(
        height: 50.h,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: AppColors.WHITE,
              ),
              SizedBox(width: 16.w),
              MyText(title: title)
            ],
          ),
        ),
      ),
    );
  }
}
