import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/widgets/my_elevated_button.dart';
import 'package:stories_app/core/widgets/my_html_widget.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';
import 'package:stories_app/features/home/views/manager/share_friends_cubit/share_friends_cubit.dart';
import 'package:stories_app/features/home/views/manager/status_icon_favorite/status_icon_favorite_cubit.dart';
import 'package:stories_app/features/home/views/pages/add_report_screen.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/bottom_nav.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/photos_friends_page/icon_favorite_widget_animated.dart';
import 'package:stories_app/features/home/views/widgets/share_friends_page/my_item_card_share_friend.dart';

class ShareFriendScreen extends StatelessWidget {
  final ShareFriendsModel shareFriend;
  final int index;

  ShareFriendScreen({
    required this.shareFriend,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FacebookBannerAdWidget(),
                SizedBox(height: 10.h),
                if (shareFriend.thumbnail != null)
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 250.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.BLACK.withOpacity(.2),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: shareFriend.thumbnail!,
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
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MyText(
                        title: shareFriend.title ?? '',
                        textAlign: TextAlign.start,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<ShareFriendsCubit, ShareFriendsState>(
                          builder: (context, state) {
                            return MyText(
                              title: '${shareFriend.likes ?? "0"}',
                              fontSize: 15,
                            );
                          },
                        ),
                        SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: Stack(
                            children: [
                              IconFavoriateWidgetAnimated(
                                onTap: () {
                                  if (shareFriend.docId != null) {
                                    StatusIconFavoriteCubit.get(context)
                                        .changeStatus();
                                    Future.delayed(
                                        const Duration(milliseconds: 200), () {
                                      StatusIconFavoriteCubit.get(context)
                                          .changeStatus();
                                    });
                                    ShareFriendsCubit.get(context)
                                        .updateLikeShare(
                                      index: index,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    MyItemCardShareFriend(
                        text: 'كاتب القصة', value: shareFriend.name ?? ""),
                    SizedBox(width: 20.w),
                    MyItemCardShareFriend(
                        text: 'البلد', value: shareFriend.country ?? ""),
                  ],
                ),
                SizedBox(height: 20.h),
                MyText(
                  title: 'الوصف',
                  fontSize: 16,
                  color: AppColors.BASE_COLOR,
                ),
                SizedBox(height: 20.h),
                MyHTMLWidget(text: shareFriend.description ?? ''),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: MyElevatedButton(
                        title: 'حظر المستخدم',
                        height: 40.h,
                        background: AppColors.RED,
                        titleColor: AppColors.WHITE,
                        onPressed: shareFriend.docId == null
                            ? null
                            : () {
                                Helpers.showLoaderDialog(
                                    context, shareFriend.name!);
                              },
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: MyElevatedButton(
                        title: 'ابلاغ عن المحتوي',
                        height: 40.h,
                        borderColor: AppColors.RED,
                        background: AppColors.TRANSPARENT,
                        titleColor: AppColors.RED,
                        onPressed: () {
                          Helpers.navigationToPage(
                            context,
                            AddReportScreen(
                              docId: shareFriend.docId,
                              titleStory: shareFriend.title!,
                              usernameStory: shareFriend.name!,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationMainScreen(navigationBack: true),
    );
  }
}
