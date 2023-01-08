import 'dart:developer';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/widgets/item_download_audio_and_vedio.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/story.dart';
import 'package:stories_app/features/home/views/manager/status_load_vedio_cubit/status_load_vedio_cubit.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';
import 'package:video_player/video_player.dart';

import '../storage/db/db_const.dart';

class MyItemVedio2Widget extends StatefulWidget {
  final Story story;
  final Story storyDB;

  MyItemVedio2Widget({
    required this.story,
    required this.storyDB,
  });

  @override
  State<MyItemVedio2Widget> createState() => _MyItemVedio2WidgetState();
}

class _MyItemVedio2WidgetState extends State<MyItemVedio2Widget> {
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  @override
  void initState() {
    StatusLoadVedioCubit.get(context)
        .changeLoadVedio(StatusLoadVedioCubit.LOADING);
    if ((StoryCubit.get(context).selectedItemCategory == 0
            ? widget.story.url2
            : widget.story.url) !=
        null) {
      _initChewie();
    } else {
      StatusLoadVedioCubit.get(context)
          .changeLoadVedio(StatusLoadVedioCubit.FAILURE);
    }
    super.initState();
  }

  Future _initChewie() async {
    try {
      if (widget.story.docId == null) {
        if (StoryCubit.get(context).selectedItemCategory == 0) {
          if (widget.storyDB.url != null) {
            _controller = VideoPlayerController.file(File(widget.storyDB.url!));
          } else {
            _controller = VideoPlayerController.network(
                (StoryCubit.get(context).selectedItemCategory == 0
                    ? widget.story.url2
                    : widget.story.url)!);
          }
        } else {
          _controller = VideoPlayerController.file(File(widget.story.url!));
        }
      } else {
        if (widget.storyDB.url != null) {
          try {
            _controller = VideoPlayerController.file(File(widget.storyDB.url!));
          } catch (ex) {
            _controller = VideoPlayerController.network(
                (StoryCubit.get(context).selectedItemCategory == 0
                    ? widget.story.url2
                    : widget.story.url)!);
          }
        } else {
          print('11111111111111111111');

          _controller = VideoPlayerController.network(
              (StoryCubit.get(context).selectedItemCategory == 0
                  ? widget.story.url2
                  : widget.story.url)!);
        }
      }
      await _controller!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _controller!,
        autoPlay: true,
        showControls: true,
        showOptions: true,
      );
      StatusLoadVedioCubit.get(context)
          .changeLoadVedio(StatusLoadVedioCubit.SUCCESS);
    } catch (e) {
      log(e.toString());
      StatusLoadVedioCubit.get(context)
          .changeLoadVedio(StatusLoadVedioCubit.FAILURE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusLoadVedioCubit, StatusLoadVedioState>(
      builder: (context, state) {
        log(StatusLoadVedioCubit.get(context).status);

        if (StatusLoadVedioCubit.get(context).status ==
            StatusLoadVedioCubit.LOADING) {
          return Shimmer.fromColors(
            baseColor: AppColors.BLACK.withOpacity(.1),
            highlightColor: AppColors.BLACK,
            child: Container(
              width: double.infinity,
              height: 280.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.BLACK.withOpacity(.6),
              ),
            ),
          );
        }

        if (StatusLoadVedioCubit.get(context).status ==
            StatusLoadVedioCubit.FAILURE) {
          return Center(
              child: MyText(
            title: 'حدث خطأ ما',
          ));
        }
        return Column(
          children: [
            // BlocBuilder<ProgressLoadingCubit, ProgressLoadingState>(
            //   builder: (context, state) {
            //     if (!ProgressLoadingCubit.get(context).downloading) {
            //       return const SizedBox();
            //     }
            //     return ItemProgressWidget();
            //   },
            // ),
            // SizedBox(height: 8.h),
            AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: Chewie(controller: _chewieController!),
            ),
            SizedBox(height: 20.h),
            if (widget.story.url != null)
              ItemDownloadAudioAndVedio(
                story: widget.story,
                storyDB: widget.storyDB,
                keyDatabase: 'url',
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
    }

    if (_chewieController != null) {
      _chewieController!.dispose();
    }
    super.dispose();
  }
}
