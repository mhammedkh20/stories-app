import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';

class MyIconButtonYoutube extends StatelessWidget {
  const MyIconButtonYoutube({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Helpers.launchURL();
          },
          icon: SvgPicture.asset(
            'assets/images/youtube.svg',
            color: AppColors.WHITE,
          ),
        ),
        SizedBox(width: 13.w),
      ],
    );
  }
}
