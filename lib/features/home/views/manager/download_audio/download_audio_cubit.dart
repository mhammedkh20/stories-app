// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stories_app/core/storage/db/db_const.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/features/home/model/story.dart';

part 'download_audio_state.dart';

class DownloadAudioCubit extends Cubit<DownloadAudioState> {
  Database _database = DBProvider().database;

  List<Story> listStory = [];

  DownloadAudioCubit() : super(DownloadAudioInitial());

  static DownloadAudioCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  getStoryAudio() async {
    List<Map<String, Object?>> listMap = await _database.rawQuery(
        "SELECT * FROM ${DBConst.TABLE_STORYIES} WHERE audioUrl != '' OR url != ''");

    listStory = listMap.map((rowUserMap) => Story.fromMap(rowUserMap)).toList();

    emit(DownloadAudioInitial());
  }

  deleteStory(BuildContext context, String title) async {
    List<Map<String, Object?>> listMap = await _database.query(
      DBConst.TABLE_STORYIES,
      where: 'title = ?',
      whereArgs: [title],
    );
    Story story =
        listMap.map((rowUserMap) => Story.fromMap(rowUserMap)).toList()[0];

    bool vedio = false;
    if (story.url != null) {
      vedio = true;
    }
    print('path file ${vedio ? story.url! : story.audioUrl!}');

    bool deleted = await _database.update(
          DBConst.TABLE_STORYIES,
          {
            'url': null,
            'audioUrl': null,
          },
          where: 'title = ?',
          whereArgs: [title],
        ) !=
        0;
    if (deleted) {
      File file = File(vedio ? story.url! : story.audioUrl!);
      try {
        final dir = Directory(file.path);
        dir.deleteSync(recursive: true);
      } catch (e) {
        log(e.toString());
      }

      listStory.removeWhere((element) => title == element.title);
      Helpers.showSnackBar(context, message: 'تمت عملية الحذف بنجاح');
      emit(DownloadAudioInitial());
    } else {
      Helpers.showSnackBar(context,
          message: 'حدث خطأ ما، يرجى المحاولة فيما بعد');
    }
  }
}
