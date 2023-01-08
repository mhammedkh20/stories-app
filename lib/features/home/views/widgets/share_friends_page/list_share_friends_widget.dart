import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';
import 'package:stories_app/features/home/views/manager/share_friends_cubit/share_friends_cubit.dart';
import 'package:stories_app/features/home/views/pages/share_friend_screen.dart';
import 'package:stories_app/features/home/views/widgets/share_friends_page/item_share_friends.dart';

class ListShareFriendsWidget extends StatelessWidget {
  const ListShareFriendsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareFriendsCubit, ShareFriendsState>(
      builder: (context, state) {
        if (ShareFriendsCubit.get(context).loading) {
          return Shimmer.fromColors(
            baseColor: AppColors.BLACK.withOpacity(.3),
            highlightColor: AppColors.BLACK,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 180.h,
                      decoration: BoxDecoration(
                        color: AppColors.BLACK.withOpacity(.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    index == 9
                        ? SizedBox(height: 70.h)
                        : SizedBox(height: 10.h),
                  ],
                );
              },
            ),
          );
        }
        // ignore: prefer_is_empty
        if (ShareFriendsCubit.get(context).listShare.length == 0) {
          return Center(child: MyText(title: 'no data'));
        }
        return ListView.builder(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: 70.h,
          ),
          itemCount: ShareFriendsCubit.get(context).listShare.length,
          itemBuilder: (context, index) {
            ShareFriendsModel shareFriends =
                ShareFriendsCubit.get(context).listShare[index];
            if (shareFriends.thumbnail == null) {
              return const SizedBox();
            }
            return ItemShareFriends(
              index: index,
              shareFriends: shareFriends,
              onTap: () {
                Helpers.navigationToPage(
                  context,
                  ShareFriendScreen(
                    shareFriend: shareFriends,
                    index: index,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
