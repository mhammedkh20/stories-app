import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/utils/app_colors.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/core/widgets/item_download_audio_and_vedio.dart';
import 'package:stories_app/core/widgets/my_text.dart';
import 'package:stories_app/features/home/model/story.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_app/features/home/views/manager/story_cubit/story_cubit.dart';

class MyItemAudioWidget extends StatefulWidget {
  final Story story;
  final Story storyDB;

  const MyItemAudioWidget({
    required this.story,
    required this.storyDB,
  });

  @override
  State<MyItemAudioWidget> createState() => _MyItemAudioWidgetState();
}

class _MyItemAudioWidgetState extends State<MyItemAudioWidget>
    with TickerProviderStateMixin {
  final _audioPlayer = AudioPlayer();
  Database _database = DBProvider().database;

  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    if ((StoryCubit.get(context).selectedItemCategory == 0
            ? widget.story.audioUrl2
            : widget.story.audioUrl) !=
        null) {
      setAudio();
      _audioPlayer.onPlayerStateChanged.listen((event) {
        _isPlaying = event == PlayerState.PLAYING;
      });

      _audioPlayer.onDurationChanged.listen((event) {
        if (mounted) {
          setState(() {
            _duration = event;
          });
        }
      });

      _audioPlayer.onAudioPositionChanged.listen((event) {
        if (mounted) {
          setState(() {
            _position = event;
          });
        }
      });
    }

    super.initState();
  }

  Future stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    stopAudio();
    if (!mounted) _audioPlayer.dispose();
    log('_audioPlayer.dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    stopAudio();
    log('_audioPlayer.deactivate');

    super.deactivate();
  }

  Future setAudio() async {
    if (widget.story.docId == null) {
      await _audioPlayer.play(
          (StoryCubit.get(context).selectedItemCategory == 0
              ? widget.story.audioUrl2
              : widget.story.audioUrl)!,
          isLocal: true);
    } else {
      if (widget.storyDB.audioUrl != null) {
        try {
          await _audioPlayer.play(widget.storyDB.audioUrl!, isLocal: true);
        } catch (ex) {
          await _audioPlayer.play(
              (StoryCubit.get(context).selectedItemCategory == 0
                  ? widget.story.audioUrl2
                  : widget.story.audioUrl)!);
        }
      } else {
        await _audioPlayer.play(
            (StoryCubit.get(context).selectedItemCategory == 0
                ? widget.story.audioUrl2
                : widget.story.audioUrl)!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.story.audioUrl}sdfasfasdf');

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
            imageUrl: widget.story.thumbnail!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator.adaptive()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        if ((StoryCubit.get(context).selectedItemCategory == 0
                ? widget.story.audioUrl2
                : widget.story.audioUrl) !=
            null)
          Column(
            children: [
              SizedBox(height: 10.h),
              Slider(
                min: 0,
                max: _duration.inSeconds.toDouble(),
                value: _position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await _audioPlayer.seek(position);
                  await _audioPlayer.pause();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: Helpers.formatTime(_position)),
                  MyText(title: Helpers.formatTime(_duration)),
                ],
              ),
              CircleAvatar(
                radius: 35.r,
                child: IconButton(
                  iconSize: 40.r,
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: () async {
                    if (_isPlaying) {
                      await _audioPlayer.pause();
                    } else {
                      _audioPlayer.resume();
                    }
                    setState(() {});
                  },
                ),
              ),
              if (widget.story.audioUrl != null)
                ItemDownloadAudioAndVedio(
                  story: widget.story,
                  keyDatabase: 'audioUrl',
                  storyDB: widget.storyDB,
                ),
            ],
          ),
      ],
    );
  }
}
