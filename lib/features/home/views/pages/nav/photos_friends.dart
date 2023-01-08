import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/utils/my_admob_ad_google.dart';
import 'package:stories_app/core/widgets/fab_widget.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/photo_friends_model.dart';
import 'package:stories_app/features/home/views/manager/photo_friends_cubit/photo_friends_cubit.dart';
import 'package:stories_app/features/home/views/pages/add_photo_friend_screen.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/photos_friends_page/item_the_best_friend_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/features/home/views/widgets/photos_friends_page/list_photos_friends_widget.dart';

class PhotosFriends extends StatelessWidget {
  const PhotosFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const FacebookBannerAdWidget(),
          SizedBox(height: 10.h),
          Expanded(
            child: BlocBuilder<PhotoFriendsCubit, PhotoFriendsState>(
              builder: (context, state) {
                if (PhotoFriendsCubit.get(context).loading) {
                  return Stack(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(height: 16.h),
                          Shimmer.fromColors(
                            baseColor: AppColors.BLACK.withOpacity(.3),
                            highlightColor: AppColors.BLACK,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
                              height: 170.r,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.BLACK.withOpacity(.1),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    color: AppColors.BLACK.withOpacity(.16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Shimmer.fromColors(
                            baseColor: AppColors.BLACK.withOpacity(.3),
                            highlightColor: AppColors.BLACK,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.3,
                                mainAxisSpacing: 10.h,
                                crossAxisSpacing: 5.w,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              itemCount: 10,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 4,
                                          color:
                                              AppColors.BLACK.withOpacity(.1)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      FabWidget(
                          title: 'شارك صورتك',
                          onPressed: () {
                            Helpers.navigationToPage(
                              context,
                              AddPhotoFrindScreen(docId: null),
                            );
                          }),
                    ],
                  );
                }
                if (PhotoFriendsCubit.get(context).listPhoto.length == 0) {
                  return Center(child: MyText(title: 'no data'));
                }
                List<PhotoFriendsModel> data =
                    PhotoFriendsCubit.get(context).listPhoto;

                return Stack(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                        bottom: 70.h,
                      ),
                      children: [
                        SizedBox(height: 16.h),
                        ItemTheBestFriendWidget(photo: data[0]),
                        SizedBox(height: 20.h),
                        ListPhotosFriendsWidget(data: data),
                      ],
                    ),
                    FabWidget(
                      title: 'شارك صورتك',
                      onPressed: () {
                        Helpers.navigationToPage(
                          context,
                          AddPhotoFrindScreen(
                            docId: data[0].docId,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
