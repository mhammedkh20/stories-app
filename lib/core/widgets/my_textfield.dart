import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final bool enabled;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const MyTextField({
    required this.hint,
    required this.iconData,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      enabled: enabled,
      style: TextStyle(
        fontSize: 13.sp,
        color: AppColors.BLACK,
        fontFamily: 'Montserrat',
      ),
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.BASE_COLOR, width: 2),
        ),
        // errorBorder: OutlineInputBorder(),
        border: OutlineInputBorder(),
        focusColor: AppColors.BASE_COLOR,
      ),
    );
  }
}
