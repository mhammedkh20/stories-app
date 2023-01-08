import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/features/home/views/manager/contact_cubit/contect_cubit.dart';
import 'package:stories_app/features/home/views/manager/photo_friends_cubit/photo_friends_cubit.dart';
import 'package:stories_app/features/home/views/manager/share_friends_cubit/share_friends_cubit.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/app_bar.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/body.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/bottom_nav.dart';
import 'package:stories_app/features/home/views/widgets/main_screen/drawar.dart';

import '../../../../core/utils/notification_api.dart';

final zoomDrawerController = ZoomDrawerController();

class MainScreen extends StatefulWidget with Helpers {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    NotificationApi.init();
    NotificationApi.requestIOSPermissions();

    StoryCubit.get(context).getMoveOfTheWeek();
    StoryCubit.get(context).getCategories();
    ShareFriendsCubit.get(context).getShareFriends();
    PhotoFriendsCubit.get(context).getPhotoFriends();
    ContactCubit.get(context).getHTMLPage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        if (notification.title != null) {
          NotificationApi.showNotification(
            id: notification.hashCode,
            title: notification.title ?? "",
            body: notification.body ?? "",
            urlImage: notification.android == null
                ? null
                : notification.android!.imageUrl,
            // payload: 'mohammed',
          );
        }
      }
    });
    FacebookAudienceNetwork.init();

    // Helpers.loadRewardedVideoAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor: AppColors.BASE_COLOR.withOpacity(.8),
      controller: zoomDrawerController,
      borderRadius: 24.0,
      showShadow: true,
      angle: 0,
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuScreen: const MyDrawer(),
      mainScreen: const Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarMainScreen(),
        body: BodyMainScreen(),
        bottomNavigationBar: BottomNavigationMainScreen(),
      ),
    );
  }
}
