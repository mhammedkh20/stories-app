import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:flutter/material.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/widgets/fab_widget.dart';
import 'package:stories_app/features/home/views/pages/add_share_friend_screen.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/facebook_banner_ad_widget.dart';
import 'package:stories_app/features/home/views/widgets/share_friends_page/list_share_friends_widget.dart';

class ShareFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const FacebookBannerAdWidget(),
          Expanded(
            child: Stack(
              children: [
                const ListShareFriendsWidget(),
                FabWidget(
                  title: 'شارك قصة',
                  onPressed: () {
                    Helpers.navigationToPage(context, AddShareFrindScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
