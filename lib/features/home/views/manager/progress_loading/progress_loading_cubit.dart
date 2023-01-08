import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stories_app/core/storage/db/db_const.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/features/home/model/loading_model.dart';
import 'package:stories_app/features/home/model/story.dart';

part 'progress_loading_state.dart';

class ProgressLoadingCubit extends Cubit<ProgressLoadingState> {
  List<LoadingModel> listLoading = [];
  final Database _database = DBProvider().database;

  ProgressLoadingCubit() : super(ProgressLoadingInitial());

  static ProgressLoadingCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  LoadingModel? getLoadingStory(String? storyId) {
    for (int i = 0; i < listLoading.length; i++) {
      if (listLoading[i].id == storyId) {
        return listLoading[i];
      }
    }
    return null;
  }

  loadingProgress(String id, bool load, double progress,
      {bool createLoading = false, int? index}) {
    if (createLoading) {
      listLoading
          .add(LoadingModel(downloading: load, id: id, progress: progress));
    } else {
      listLoading[index!].progress = progress;
      listLoading[index].downloading = load;
    }

    emit(LoadingProgress());
  }

  Future<String> downloadFile(BuildContext context, Story story,
      String extention, String keyDatabase) async {
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    File file;
    if (extention == '.mp3') {
      file = File(
          "${dir.path}/audio/${DateTime.now().microsecond}${DateTime.now().millisecond}$extention");
    } else {
      file = File(
          "${dir.path}/${DateTime.now().microsecond}${DateTime.now().millisecond}$extention");
    }
    int indexLoading = 0;

    try {
      loadingProgress(story.docId!, true, 0, createLoading: true);
      bool theFirstLoop = true;
      await dio.download(
          keyDatabase == 'url' ? story.url! : story.audioUrl!, file.path,
          onReceiveProgress: (rec, total) {
        if (theFirstLoop) {
          theFirstLoop = false;
          indexLoading =
              listLoading.indexWhere((element) => element.id == story.docId);
        }
        loadingProgress(story.docId!, true, (((rec / total) * 100) / 100),
            index: indexLoading);
      });
    } catch (e) {
      log(e.toString());
    }

    loadingProgress(story.docId!, false, 1, index: indexLoading);

    await _database.update(
      DBConst.TABLE_STORYIES,
      {keyDatabase: file.path},
      where: 'title = ?',
      whereArgs: [story.title],
    );

    if (keyDatabase == 'url') {
      await GallerySaver.saveVideo(file.path, albumName: 'vedio');
    }

    return file.path;
  }
}
