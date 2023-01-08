import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/features/home/views/manager/pixels_scroll_controller/pixels_scroll_controller_cubit.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_native_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/categories_widget.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/item_film_widget.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/list_stories_widget.dart';
import 'package:wakelock/wakelock.dart';

class Stories extends StatefulWidget {
  Stories({Key? key}) : super(key: key);

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      PixelsScrollControllerCubit.get(context)
          .scrollingScreen(scrollController.position.pixels);
    });
    Wakelock.enable();
    super.initState();
  }

  @override
  void dispose() {
    Wakelock.disable();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const FacebookBannerAdWidget(),
              SizedBox(height: 16.h),
              ItemFilmWidget(),
              SizedBox(height: 12.r),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const FacebookNativeAdWidget(),
              ),
              ListStoriesWidget(),
              SizedBox(height: 12.r),
              const CategoriesWidget(),
              SizedBox(height: 8.r),
            ],
          ),
        ),
      ],
    );
  }
}
