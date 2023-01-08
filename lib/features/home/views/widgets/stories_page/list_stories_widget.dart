// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/story.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';
import 'package:stories_app/features/home/views/pages/story_screen.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/item_story_widget.dart';

class ListStoriesWidget extends StatelessWidget {
  bool clearNavigationRoot;

  final Database _database = DBProvider().database;

  ListStoriesWidget({Key? key, this.clearNavigationRoot = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      builder: (context, state) {
        if (StoryCubit.get(context).listCategories == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (StoryCubit.get(context).loadingCategories) {
          return Shimmer.fromColors(
            baseColor: AppColors.BLACK.withOpacity(.3),
            highlightColor: AppColors.BLACK,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.r,
                  crossAxisSpacing: 5.r,
                  childAspectRatio: 1 / 1.4),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.BLACK.withOpacity(.6),
                  ),
                );
              },
            ),
          );
        }

        // ignore: prefer_is_empty
        if (StoryCubit.get(context)
                .listCategories![StoryCubit.get(context).selectedItemCategory]
                .listStories!
                .length ==
            0) {
          return Center(
            child: MyText(title: 'no data'),
          );
        }
        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.r,
              crossAxisSpacing: 5.r,
              childAspectRatio: 1 / 1.4),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: StoryCubit.get(context)
              .listCategories![StoryCubit.get(context).selectedItemCategory]
              .listStories!
              .length,
          itemBuilder: (context, index) {
            Story story = StoryCubit.get(context)
                .listCategories![StoryCubit.get(context).selectedItemCategory]
                .listStories![index];

            return ItemStoryWidget(
              name: story.title,
              urlImage: story.thumbnail,
              onTap: () async {
                Story storyDB = await Helpers.getStoryFromDb(
                    context, _database, story.title ?? "");

                Widget widget = StoryScreen(
                  story: story,
                  docId: StoryCubit.get(context)
                      .listCategories![
                          StoryCubit.get(context).selectedItemCategory]
                      .docId,
                  categoryId: StoryCubit.get(context)
                      .listCategories![
                          StoryCubit.get(context).selectedItemCategory]
                      .docId,
                  indexStory: index,
                  indexCategory: StoryCubit.get(context).selectedItemCategory,
                  storyDB: storyDB,
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
              onTapIconFavorite: () {},
            );
          },
        );
      },
    );
  }
}
