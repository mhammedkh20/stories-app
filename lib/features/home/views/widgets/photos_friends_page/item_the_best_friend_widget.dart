import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/photo_friends_model.dart';
import 'package:stories_app/features/home/views/manager/photo_friends_cubit/photo_friends_cubit.dart';
import 'package:stories_app/features/home/views/manager/status_icon_favorite/status_icon_favorite_cubit.dart';
import 'package:stories_app/features/home/views/widgets/photos_friends_page/icon_favorite_widget_animated.dart';
import 'package:stories_app/features/home/views/widgets/photos_friends_page/number_views_widget.dart';

class ItemTheBestFriendWidget extends StatelessWidget {
  final PhotoFriendsModel photo;

  const ItemTheBestFriendWidget({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        clipBehavior: Clip.antiAlias,
        height: 170.r,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.WHITE,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: AppColors.BLACK.withOpacity(.16),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (photo.docId != null) {
              PhotoFriendsCubit.get(context).updateLikePhoto(0);
            }
          },
          child: photo.file != null
              ? Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: CachedNetworkImage(
                        imageUrl: photo.file!,
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
                    ),
                    Container(
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
                    PositionedDirectional(
                      bottom: 8.r,
                      start: 16.r,
                      end: 16.r,
                      child: MyText(
                        title: photo.name != null ? photo.name! : "",
                        color: AppColors.WHITE,
                        textAlign: TextAlign.center,
                        textOverflow: true,
                        maxLines: 3,
                      ),
                    ),
                    NumberViewsWidget(numberViews: photo.likes ?? 0),
                    IconFavoriateWidgetAnimated(
                      onTap: () {
                        if (photo.docId != null) {
                          PhotoFriendsCubit.get(context).updateLikePhoto(0);
                        }
                      },
                    ),
                  ],
                )
              : const Icon(Icons.error),
        ),
      ),
    );
  }
}
