import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';
import 'package:stories_app/features/home/views/pages/main_screen.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/drawar.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_native_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/categories_widget2.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/list_stories_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatelessWidget {
  final String title;
  final int indexCategory;

  const CategoryScreen({required this.title, required this.indexCategory});

  @override
  Widget build(BuildContext context) {
    StoryCubit.get(context).listCategories![indexCategory];
    StoryCubit.get(context).onClickItemCategory(indexCategory);

    return ZoomDrawer(
      menuBackgroundColor: AppColors.BASE_COLOR.withOpacity(.8),
      controller: zoomDrawerController,
      borderRadius: 24.0,
      showShadow: true,
      angle: 0,
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuScreen: const MyDrawer(clearNavigationRoot: true),
      mainScreen: Scaffold(
        appBar: AppBar(
          title: MyText(title: title),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                zoomDrawerController.toggle!();
              },
              icon: const Icon(
                Icons.menu,
                color: AppColors.WHITE,
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            const FacebookBannerAdWidget(),
            ListStoriesWidget(clearNavigationRoot: true),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const FacebookNativeAdWidget(),
            ),
            SizedBox(height: 10.h),
            CategoriesWidget2(),
          ],
        ),
      ),
    );
  }
}
