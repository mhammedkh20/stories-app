import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';

// ignore: must_be_immutable
class MyElevatedButton extends StatelessWidget {
  String title;
  VoidCallback? onPressed;
  double fontSize;
  Color? titleColor;
  FontWeight fontWeight;
  Color borderColor;
  Color? background;
  double borderWidth;
  double height;
  double width;
  bool enabledBorder;
  double? elevation;
  IconData? iconData;

  MyElevatedButton(
      {Key? key,
      required this.title,
      this.onPressed,
      this.fontSize = 12,
      this.titleColor,
      this.fontWeight = FontWeight.w400,
      this.borderColor = AppColors.TRANSPARENT,
      this.background,
      this.borderWidth = 2,
      this.height = 48,
      this.width = double.infinity,
      this.enabledBorder = true,
      this.elevation,
      this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: AppColors.TRANSPARENT,
          elevation: elevation,
          primary: background,
          minimumSize: Size(
            width,
            height.h,
          ),
          side: enabledBorder
              ? BorderSide(
                  color: borderColor,
                  width: borderWidth,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) Icon(iconData),
            MyText(
              title: title,
              fontSize: fontSize,
              color: titleColor,
              fontWeight: fontWeight,
            ),
          ],
        ),
      ),
    );
  }
}
