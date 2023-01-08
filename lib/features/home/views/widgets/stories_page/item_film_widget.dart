import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octo_image/octo_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/story.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';
import 'package:stories_app/features/home/views/pages/story_screen.dart';

class ItemFilmWidget extends StatelessWidget {
  final Database _database = DBProvider().database;

  ItemFilmWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      builder: (context, state) {
        if (StoryCubit.get(context).loadingFilem) {
          // return const Center(child: CircularProgressIndicator.adaptive());
          return Shimmer.fromColors(
            baseColor: AppColors.BLACK.withOpacity(.3),
            highlightColor: AppColors.BLACK,
            child: Container(
              height: 150.r,
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: StoryCubit.get(context).clickItemFilmMove ? 10 : 0,
                vertical: StoryCubit.get(context).clickItemFilmMove ? 10 : 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.BLACK.withOpacity(.6),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: AppColors.BLACK.withOpacity(.16),
                  ),
                ],
              ),
            ),
          );
        }
        Story? story = StoryCubit.get(context).movieOfTheWeek;
        if (story == null) {
          return const SizedBox();
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            clipBehavior: Clip.antiAlias,
            height: 150.r,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: StoryCubit.get(context).clickItemFilmMove ? 10 : 0,
              vertical: StoryCubit.get(context).clickItemFilmMove ? 10 : 0,
            ),
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
              onTap: () async {
                StoryCubit.get(context).onClickItemFilmMove();
                Future.delayed(const Duration(milliseconds: 300), () {
                  StoryCubit.get(context).onClickItemFilmMove();
                });
                Helpers.navigationToPage(
                  context,
                  StoryScreen(
                    story: story,
                    categoryId: 'categoryId',
                    indexCategory: 0,
                    indexStory: 0,
                    okVedio: true,
                    storyDB: Story(),
                  ),
                );
              },
              child: story.thumbnail != null
                  ? Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: CachedNetworkImage(
                            imageUrl: story.thumbnail!,
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
                            title: story.title != null ? story.title! : "",
                            color: AppColors.WHITE,
                            textAlign: TextAlign.center,
                            textOverflow: true,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    )
                  : const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
