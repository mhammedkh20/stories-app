import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/features/home/model/story.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/widgets/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyItemVedio extends StatefulWidget {
  final Story story;
  bool playVedio = false;

  MyItemVedio({required this.story});

  @override
  State<MyItemVedio> createState() => _MyItemVedioState();
}

class _MyItemVedioState extends State<MyItemVedio> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    if (widget.story.url != null) {
      _controller = VideoPlayerController.network(widget.story.url!,
          formatHint: VideoFormat.hls)
        ..initialize();
      _controller!.setLooping(true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.r,
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.playVedio // widget.visibleItem &&
          ? vedioWidget()
          : imageWidget(),
    );
  }

  Widget imageWidget() {
    return Stack(
      children: [
        widget.story.thumbnail == null
            ? Image.asset(
                'assets/images/no_data.png',
                width: double.infinity,
                height: double.infinity,
              )
            : Image.network(
                widget.story.thumbnail ?? "",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.BLACK.withOpacity(0),
                AppColors.BLACK.withOpacity(.5),
                AppColors.BLACK.withOpacity(1),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: MyText(
              title: widget.story.title ?? "",
              textOverflow: true,
              maxLines: 4,
              fontSize: 15,
              height: 1.7,
              textAlign: TextAlign.start,
              color: Theme.of(context).primaryTextTheme.headline6!.color,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 60.r,
            height: 60.r,
            child: Material(
              borderRadius: BorderRadius.circular(40),
              color: Theme.of(context).accentColor.withOpacity(.3),
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  changeStatusVedio();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 40.r,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  changeStatusVedio() {
    widget.playVedio = !widget.playVedio;
    if (widget.story.url != null) {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      setState(() {});
    }
  }

  Widget vedioWidget() {
    if (widget.story.url != null) {
      return GestureDetector(
          onTap: () {
            changeStatusVedio();
          },
          child: Column(
            children: [
              Expanded(child: VideoPlayer(_controller!)),
              VideoProgressIndicator(
                _controller!,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  bufferedColor: AppColors.BASE_COLOR,
                ),
              )
            ],
          ));
    } else {
      return Container(
        alignment: Alignment.center,
        child: MyText(
          title: 'لا يوجد فيديو',
        ),
      );
    }
  }
}
