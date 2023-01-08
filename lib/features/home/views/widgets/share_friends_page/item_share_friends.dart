import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';
import 'package:stories_app/features/home/views/manager/share_friends_cubit/share_friends_cubit.dart';

class ItemShareFriends extends StatelessWidget {
  final ShareFriendsModel shareFriends;
  final GestureTapCallback onTap;
  final int index;

  const ItemShareFriends({
    required this.shareFriends,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: double.infinity,
          height: 180.h,
          decoration: BoxDecoration(
            color: AppColors.BASE_COLOR.withOpacity(.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: CachedNetworkImage(
                  imageUrl: shareFriends.thumbnail!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Material(
                color: AppColors.TRANSPARENT,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.BLACK.withOpacity(0),
                          AppColors.BLACK.withOpacity(.2),
                          AppColors.BLACK.withOpacity(.4),
                          AppColors.BLACK.withOpacity(.8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                bottom: 8.r,
                start: 16.r,
                end: 16.r,
                child: MyText(
                  title: shareFriends.title != null ? shareFriends.title! : "",
                  color: AppColors.WHITE,
                  textAlign: TextAlign.center,
                  textOverflow: true,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
