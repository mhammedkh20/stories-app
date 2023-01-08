import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/views/widgets/photos_friends_page/icon_favorite_widget_animated.dart';
import 'package:stories_app/features/home/views/widgets/photos_friends_page/number_views_widget.dart';

class ItemStoryWidget extends StatelessWidget {
  final String? name;
  final String? urlImage;
  final bool forPhoto;
  final int likes;
  final GestureTapCallback? onTap;
  final GestureTapCallback onTapIconFavorite;

  const ItemStoryWidget({
    required this.name,
    required this.urlImage,
    required this.onTap,
    required this.onTapIconFavorite,
    this.forPhoto = false,
    this.likes = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 4, color: AppColors.BLACK.withOpacity(.16)),
        ],
      ),
      child: Stack(children: [
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: CachedNetworkImage(
            imageUrl: urlImage!,
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
                    AppColors.BLACK.withOpacity(.9),
                  ],
                ),
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 10.h,
          start: 10.w,
          end: 10.w,
          child: MyText(
            color: AppColors.WHITE,
            title: name!,
            textAlign: TextAlign.center,
          ),
        ),
        if (forPhoto) NumberViewsWidget(numberViews: likes),
        if (forPhoto)
          IconFavoriateWidgetAnimated(
            onTap: onTapIconFavorite,
          ),
      ]),
    );
  }
}
