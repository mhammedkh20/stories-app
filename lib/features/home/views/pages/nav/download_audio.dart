// ignore_for_file: use_build_context_synchronously

import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/utils/my_admob_ad_google.dart';
import 'package:stories_app/core/widgets/my_elevated_button.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/views/manager/download_audio/download_audio_cubit.dart';
import 'package:stories_app/features/home/views/manager/main_cubit/main_cubit.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';
import 'package:stories_app/features/home/views/pages/story_screen.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/stories_page/item_story_widget.dart';

import '../../../model/story.dart';

class DownloadAudio extends StatelessWidget {
  final Database _database = DBProvider().database;

  DownloadAudio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DownloadAudioCubit.get(context).getStoryAudio();
    return SafeArea(
      child: Column(
        children: [
          const FacebookBannerAdWidget(),
          SizedBox(height: 10.h),
          Expanded(
            child: BlocBuilder<DownloadAudioCubit, DownloadAudioState>(
              builder: (context, state) {
                if (DownloadAudioCubit.get(context).listStory.length == 0) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              'assets/images/no_data_found.json',
                              width: 250.w,
                            ),
                            SizedBox(height: 20.h),
                            MyText(
                              title: 'يمكنك تصفح القصص وتنزيل اي قصة تريدها',
                              fontSize: 13,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30.h),
                            MyElevatedButton(
                              title: 'تصفح القصص',
                              onPressed: () {
                                MainCubit.get(context).changeIndexBottomNav(0);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.r,
                      crossAxisSpacing: 5.r,
                      childAspectRatio: 1 / 1.4),
                  shrinkWrap: true,
                  itemCount: DownloadAudioCubit.get(context).listStory.length,
                  itemBuilder: (context, index) {
                    Story story =
                        DownloadAudioCubit.get(context).listStory[index];

                    return ItemStoryWidget(
                      name: story.title,
                      urlImage: story.thumbnail,
                      onTap: () async {
                        if (StoryCubit.get(context).selectedItemCategory == 0) {
                          StoryCubit.get(context).onClickItemCategory(1);
                        }
                        Story storyDB = await Helpers.getStoryFromDb(
                            context, _database, story.title ?? "");

                        Helpers.navigationToPage(
                          context,
                          StoryScreen(
                            story: story,
                            categoryId: '0',
                            indexStory: index,
                            indexCategory: 0,
                            storyDB: storyDB,
                          ),
                        );
                      },
                      onTapIconFavorite: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
