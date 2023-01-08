// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/utils/app_colors.dart';

class MySearchView extends StatelessWidget {
  final String hint;

  final TextEditingController searchViewController;

  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTapDeleteText;
  final VoidCallback? btnSearch;
  final ValueChanged<String>? onSubmitted;
  final String textSearch;
  // final bool autoFocus;

  const MySearchView({
    required this.searchViewController,
    required this.hint,
    required this.textSearch,
    this.onChange,
    this.onTapDeleteText,
    this.btnSearch,
    this.onSubmitted,
    // this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 45.h,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: AppColors.BLACK.withOpacity(.16),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: AppColors.BG_TITLE_SOURCES,
              size: 24.r,
            ),
            onPressed: btnSearch,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.go,
              textAlign: TextAlign.start,
              controller: searchViewController,
              onSubmitted: onSubmitted,
              onChanged: onChange,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration(
                fillColor: Theme.of(context).accentColor,
                filled: true,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 2.h),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  color: AppColors.BG_TITLE_SOURCES,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w),
          textSearch == ''
              ? const SizedBox()
              : GestureDetector(
                  onTap: onTapDeleteText,
                  child: const Icon(
                    Icons.cancel,
                    color: AppColors.BG_TITLE_SOURCES,
                  ),
                ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
