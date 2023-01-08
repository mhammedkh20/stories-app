import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/features/home/views/pages/category_screen.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/item_category.dart';

class CategoriesWidget2 extends StatefulWidget {
  CategoriesWidget2({Key? key}) : super(key: key);

  @override
  State<CategoriesWidget2> createState() => _CategoriesWidget2State();
}

class _CategoriesWidget2State extends State<CategoriesWidget2> {
  final ScrollController _controller = ScrollController();

  final double _height = 105.r;

  bool check = true;
  int _itemIndex = 0;

  late Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.r,
      child: BlocBuilder<StoryCubit, StoryState>(
        builder: (context, state) {
          if (StoryCubit.get(context).loadingCategories) {
            return Shimmer.fromColors(
              baseColor: AppColors.BLACK.withOpacity(.3),
              highlightColor: AppColors.BLACK,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (conetxt, index) {
                  return Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 85.r,
                            height: 85.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.BLACK.withOpacity(.1),
                            ),
                          ),
                          SizedBox(height: 10.r),
                          Container(
                            width: 60.r,
                            height: 20.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.BLACK.withOpacity(.04),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),
                    ],
                  );
                },
              ),
            );
          }

          if (StoryCubit.get(context).listCategories == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (check) {
            check = false;
            _timer = Timer.periodic(
                const Duration(
                    // milliseconds:
                    //     StoryCubit.get(context).listCategories!.length * 800,
                    seconds: 3), (Timer timer) {
              if (mounted) {
                if (_itemIndex ==
                    (StoryCubit.get(context).listCategories!.length - 2)) {
                  _itemIndex = 0;
                } else {
                  _itemIndex++;
                }
                setState(() {
                  // if (_controller.position.pixels == 0) {
                  _animateToIndex(_itemIndex);
                  // } else {
                  //   _animateToIndex(0);
                  // }
                });
              }
            });
          }

          return ListView.builder(
            controller: _controller,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: StoryCubit.get(context).listCategories!.length,
            itemBuilder: (conetxt, index) {
              return Row(
                children: [
                  ItemCategory(
                    index: index,
                    category: StoryCubit.get(context).listCategories![index],
                    onTap: () {
                      Helpers.navigationToPage(
                        context,
                        CategoryScreen(
                          indexCategory: index,
                          title: StoryCubit.get(context)
                                  .listCategories![index]
                                  .name ??
                              "",
                        ),
                      );
                    },
                  ),
                  SizedBox(
                      width: 20
                          .w), // StoryCubit.get(context).onClickItemCategory(index);
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _height,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
