// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stories_app/core/storage/db/db_const.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/my_elevated_button.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/bottom_nav.dart';
import 'package:stories_app/features/home/model/story.dart';
import 'package:stories_app/features/home/views/manager/progress_loading/progress_loading_cubit.dart';
import 'package:stories_app/features/home/views/manager/share_friends_cubit/share_friends_cubit.dart';
import 'package:stories_app/features/home/views/pages/main_screen.dart';
import 'package:stories_app/features/home/views/pages/nav/contact_us.dart';
import 'package:stories_app/features/home/views/pages/nav/download_audio.dart';
import 'package:stories_app/features/home/views/pages/nav/photos_friends.dart';
import 'package:stories_app/features/home/views/pages/nav/share_friends.dart';
import 'package:stories_app/features/home/views/pages/nav/stories.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Helpers {
  static bool showNativeAds = true;

  BottomNav getPage(BuildContext context, int index) {
    return [
      BottomNav(AppLocalizations.of(context)!.stories, Stories()),
      BottomNav(AppLocalizations.of(context)!.shareFriends, ShareFriends()),
      BottomNav(
          AppLocalizations.of(context)!.photosFriends, const PhotosFriends()),
      BottomNav(AppLocalizations.of(context)!.download, DownloadAudio()),
      BottomNav(AppLocalizations.of(context)!.contactWithUs, const ContactUs()),
    ][index];
  }

  static oriantationDecive() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void navigationReplacementToPage(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void popAllScreensOnBackStack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
      (route) => false,
    );
  }

  static void navigationToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static launchURL() async {
    String url = 'https://www.youtube.com/channel/UC4TGB3p6GnN_FIrwiZbTp1w';
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse('youtube://$url'))) {
        await launchUrlString(
          'youtube://$url',
        );
      } else {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrlString('$url');
        } else {
          throw 'Could not launch $url';
        }
      }
    } else {
      if (await launchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds);
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  static showSnackBar(
    BuildContext context, {
    required String message,
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MyText(
          title: message,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.WHITE,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        backgroundColor: error ? AppColors.RED : AppColors.GREEN,
      ),
    );
  }

  static Future<bool> getStoryAudioOrVedioDownloaded(
      Database database, String title, String extention) async {
    List<Map<String, Object?>> listMap = await database.query(
      DBConst.TABLE_STORYIES,
      where: 'title = ?',
      whereArgs: [title],
    );

    List<Story> listStory =
        listMap.map((rowUserMap) => Story.fromMap(rowUserMap)).toList();

    if (extention == '.mp3') {
      return listStory[0].audioUrl != null;
    } else {
      return listStory[0].url != null;
    }
  }

  static showLoaderDialog(BuildContext context, String username) {
    showDialog(
      barrierDismissible: true,
      context: context,
      barrierColor: AppColors.BLACK.withOpacity(.4),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            fit: StackFit.loose,
            children: [
              SizedBox(
                height: 300.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 60.r),
                        MyText(title: 'حظر مستخدم', fontSize: 14),
                        SizedBox(height: 30.r),
                        MyText(
                          title:
                              'ستقوم بعميلة حظر للمستخدم ولن يظهر لك اي محتوى يتعلق بالمستخدم',
                          fontSize: 12,
                          color: AppColors.GRAY,
                        ),
                        SizedBox(height: 30.r),
                        Row(
                          children: [
                            Expanded(
                              child: MyElevatedButton(
                                title: 'اغلاق',
                                height: 35.h,
                                fontSize: 10,
                                borderColor: AppColors.RED,
                                background: AppColors.TRANSPARENT,
                                titleColor: AppColors.RED,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: MyElevatedButton(
                                title: 'حظر المستخدم',
                                height: 35.h,
                                fontSize: 10,
                                background: AppColors.RED,
                                titleColor: AppColors.WHITE,
                                onPressed: () {
                                  ShareFriendsCubit.get(context)
                                      .banUser(username);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: -45.r,
                child: Lottie.asset('assets/images/ban_user.json',
                    width: 90.r, height: 90.r),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<Story> getStoryFromDb(
    BuildContext context,
    Database database,
    String title,
  ) async {
    double widtVedio = MediaQuery.of(context).size.width - (32.w);
    List<Map<String, Object?>> listMap = await database.query(
      DBConst.TABLE_STORYIES,
      where: 'title = ?',
      whereArgs: [title],
    );

    return listMap.map((rowUserMap) => Story.fromMap(rowUserMap)).toList()[0];
  }

  static Future<String> downloadFile(String url, String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    File file = File(filePath);

    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static bool _isRewardedAdLoaded = false;
  static void loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          _isRewardedAdLoaded = false;
          loadRewardedVideoAd();
        }
      },
    );
  }
}
