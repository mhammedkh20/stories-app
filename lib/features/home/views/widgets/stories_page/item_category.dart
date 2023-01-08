import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/features/home/model/category.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';

class ItemCategory extends StatelessWidget {
  final int index;
  final Category category;
  final GestureTapCallback? onTap;

  const ItemCategory(
      {required this.index, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.center,
      height:
          StoryCubit.get(context).selectedItemCategory == index ? 135.r : 140.r,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                clipBehavior: Clip.antiAlias,
                height: StoryCubit.get(context).selectedItemCategory == index
                    ? 80.r
                    : 85.r,
                width: StoryCubit.get(context).selectedItemCategory == index
                    ? 80.r
                    : 85.r,
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                decoration: BoxDecoration(
                    color: AppColors.BASE_COLOR.withOpacity(.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 2,
                        color: StoryCubit.get(context).selectedItemCategory ==
                                index
                            ? AppColors.BASE_COLOR.withOpacity(.7)
                            : AppColors.TRANSPARENT)),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CachedNetworkImage(
                    imageUrl: category.thumbnail!,
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
              ),
              SizedBox(height: 10.r),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                style: TextStyle(
                    fontWeight:
                        StoryCubit.get(context).selectedItemCategory == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                    color: AppColors.BLACK,
                    fontSize: 15.sp),
                child: Text(
                  category.name ?? '',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
