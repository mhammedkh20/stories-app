import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';

class ItemDrawer extends StatelessWidget {
  final String title;
  final String icon;
  final GestureTapCallback? onTap;
  final double heightAndWidth;

  const ItemDrawer({
    required this.icon,
    required this.title,
    required this.onTap,
    this.heightAndWidth = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 50.h,
            width: double.infinity,
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: MyText(
                        title: title,
                        color: AppColors.WHITE,
                        fontSize: 12,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl: icon,
                        height: heightAndWidth.r,
                        width: heightAndWidth.r,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator.adaptive()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
