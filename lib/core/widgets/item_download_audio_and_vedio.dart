// ignore_for_file: use_build_context_synchronously
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/utils/my_admob_ad_google.dart';
import 'package:stories_app/core/widgets/my_elevated_button.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/loading_model.dart';
import 'package:stories_app/features/home/model/story.dart';
import 'package:stories_app/features/home/views/manager/download_audio/download_audio_cubit.dart';
import 'package:stories_app/features/home/views/manager/progress_loading/progress_loading_cubit.dart';

class ItemDownloadAudioAndVedio extends StatefulWidget {
  final Story story;
  final Story storyDB;
  final String keyDatabase;

  ItemDownloadAudioAndVedio({
    required this.story,
    required this.keyDatabase,
    required this.storyDB,
  });

  @override
  State<ItemDownloadAudioAndVedio> createState() =>
      _ItemDownloadAudioAndVedioState();
}

class _ItemDownloadAudioAndVedioState extends State<ItemDownloadAudioAndVedio> {
  Database _database = DBProvider().database;

  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
  }

  _createInterstitiaAd() {
    InterstitialAd.load(
      adUnitId: MyAdmobAdsGoogle.getInterstitialAdUnitId()!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitiaAd();
        },
      );
      _interstitialAd!.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15.h),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: BlocBuilder<ProgressLoadingCubit, ProgressLoadingState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.storyDB.audioUrl != null ||
                      widget.storyDB.url != null)
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          DownloadAudioCubit.get(context)
                              .deleteStory(context, widget.story.title ?? "");
                        },
                        child: MyText(
                          title: 'حذف الملف',
                          fontSize: 11,
                        ),
                      ),
                    ),
                  if (widget.storyDB.audioUrl != null ||
                      widget.storyDB.url != null)
                    SizedBox(width: 15.w),
                  Expanded(
                    flex: 2,
                    child: MyElevatedButton(
                      iconData: Icons.download,
                      title: widget.storyDB.audioUrl == null &&
                              widget.storyDB.url == null
                          ? getTitle(context)
                          : 'تم تحميل الملف',
                      width: 100.w,
                      background: ProgressLoadingCubit.get(context)
                                  .getLoadingStory(widget.story.docId) !=
                              null
                          ? ProgressLoadingCubit.get(context)
                                  .getLoadingStory(widget.story.docId)!
                                  .downloading
                              ? AppColors.GREEN
                              : AppColors.BASE_COLOR
                          : AppColors.BASE_COLOR,
                      height: 40.h,
                      onPressed: widget.storyDB.audioUrl == null &&
                              widget.storyDB.url == null
                          ? widget.story.docId != null
                              ? () async {
                                  Story storyDB2 = await Helpers.getStoryFromDb(
                                      context,
                                      _database,
                                      widget.story.title ?? "");
                                  if (storyDB2.audioUrl == null &&
                                      storyDB2.url == null) {
                                    if (widget.story.title != null) {
                                      if (ProgressLoadingCubit.get(context)
                                              .getLoadingStory(
                                                  widget.story.docId!) ==
                                          null) {
                                        ProgressLoadingCubit.get(context)
                                            .downloadFile(
                                                context,
                                                widget.story,
                                                widget.keyDatabase == 'url'
                                                    ? '.mp4'
                                                    : '.mp3',
                                                widget.keyDatabase);
                                      }
                                    }
                                  } else {
                                    Helpers.showSnackBar(context,
                                        message: 'تم تحميل الملف بالفعل',
                                        error: true);
                                  }
                                }
                              : null
                          : null,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  String getTitle(BuildContext context) {
    LoadingModel? model =
        ProgressLoadingCubit.get(context).getLoadingStory(widget.story.docId);

    if (model != null) {
      if (model.progress == 0) {
        return 'التحميل';
      } else if (model.progress == 1) {
        return 'تم انتهاء التحميل';
      } else {
        return 'جاري التحميل ${(model.progress * 100).toStringAsFixed(0)} %';
      }
    } else {
      return 'التحميل';
    }
  }
}
