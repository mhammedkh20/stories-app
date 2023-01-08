import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';
import 'package:stories_app/features/home/views/pages/category_screen.dart';
import 'package:stories_app/features/home/views/pages/main_screen.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/item_drawer.dart';

class MyDrawer extends StatelessWidget {
  final bool clearNavigationRoot;
  const MyDrawer({Key? key, this.clearNavigationRoot = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: BlocBuilder<StoryCubit, StoryState>(
        builder: (context, state) {
          if (StoryCubit.get(context).loadingCategories) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: AppColors.BLACK.withOpacity(.3),
                highlightColor: AppColors.BLACK,
                child: ListView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 50.h,
                          color: AppColors.BLACK.withOpacity(.1),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    );
                  },
                ),
              ),
            );
          }
          return Center(
            child: ListView.builder(
              itemCount: StoryCubit.get(context).listCategories!.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 30.h),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    if (index == 0)
                      ItemDrawer(
                        heightAndWidth: 30,
                        title: 'الصفحة الرئيسية',
                        icon:
                            'https://cdn-icons-png.flaticon.com/512/69/69524.png',
                        onTap: () {
                          ZoomDrawer.of(context)!.close();
                          bool canPop = Navigator.of(context).canPop();
                          if (canPop) {
                            Helpers.popAllScreensOnBackStack(context);
                          }
                        },
                      ),
                    ItemDrawer(
                      title:
                          StoryCubit.get(context).listCategories![index].name ??
                              "",
                      icon: StoryCubit.get(context)
                              .listCategories![index]
                              .thumbnail ??
                          "",
                      onTap: () {
                        ZoomDrawer.of(context)!.close();
                        Widget widget = CategoryScreen(
                          indexCategory: index,
                          title: StoryCubit.get(context)
                                  .listCategories![index]
                                  .name ??
                              "",
                        );
                        if (clearNavigationRoot) {
                          Helpers.navigationReplacementToPage(
                            context,
                            widget,
                          );
                        } else {
                          Helpers.navigationToPage(
                            context,
                            widget,
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
