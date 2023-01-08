import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stories_app/core/storage/db/db_const.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/storage/firebase/firestore/fb_firestore_controller.dart';
import 'package:stories_app/core/storage/pref/shared_pref_controller.dart';
import 'package:stories_app/features/home/domin/stories_repo.dart';
import 'package:stories_app/features/home/model/category.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';
import 'package:stories_app/features/home/model/story.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class StoriesRepoImp extends StoriesRepo {
  final _firestoreInstance = FbFirestoreController();
  Database _database = DBProvider().database;

  @override
  Future<Story?> getMovieOfTheWeek() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestoreInstance.getMovieOfTheWeek();

      Story story = Story.fromQueryDocSnapshot(querySnapshot.docs[0]);

      await _database.delete(DBConst.TABLE_MOVIE_WEEK);
      await _database.insert(DBConst.TABLE_MOVIE_WEEK, story.toMapDBFilm());

      return story;
    } else {
      List<Map<String, Object?>> listMap =
          await _database.query(DBConst.TABLE_MOVIE_WEEK);

      List<Story> listStory =
          listMap.map((rowUserMap) => Story.fromMap(rowUserMap)).toList();
      if (listStory.length >= 0) {
        return listStory[0];
      }
      return null;
    }
  }

  @override
  Future<List<Category>?> getCategories() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestoreInstance.getCategories();

      List<Category>? listCategory = [];
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        listCategory.add(Category.fromQueryDocSnapshot(querySnapshot.docs[i]));

        listCategory[i].listStories =
            await getListStoryFromCategory(querySnapshot.docs[i].id);
      }

      // await _database.delete(DBConst.TABLE_STORYIES);
      // await _database.delete(DBConst.TABLE_CATRGORIES);
      if (SharedPrefController().getRunApp == null) {
        await SharedPrefController().setRunApp('run');
        for (int i = 0; i < listCategory.length; i++) {
          int indexRow = await _database.insert(
              DBConst.TABLE_CATRGORIES, listCategory[i].toMap());
          if (listCategory[i].listStories != null) {
            for (int j = 0; j < listCategory[i].listStories!.length; j++) {
              listCategory[i].listStories![j].idCategory = indexRow;

              await _database.insert(DBConst.TABLE_STORYIES,
                  listCategory[i].listStories![j].toMapForCategoryId());
            }
          }
        }
      }
      List<Story> listAllStories = [];
      for (int i = 0; i < listCategory.length; i++) {
        if (listCategory[i].listStories != null) {
          if (listCategory[i].listStories!.length > 5) {
            for (int j = 0; j < 5; j++) {
              listAllStories.add(listCategory[i].listStories![j]);
            }
          } else {
            for (int j = 0; j < listCategory[i].listStories!.length; j++) {
              listAllStories.add(listCategory[i].listStories![j]);
            }
          }
        }
      }

      listCategory.insert(
        0,
        Category.fromMapFromFirestore(
          {
            'docId': '0',
            'count': 0,
            'createdAt': DateTime.now().toString(),
            'updatedAt': DateTime.now().toString(),
            'name': 'كل القصص',
            'thumbnail':
                'https://cdn2.momjunction.com/wp-content/uploads/2015/08/Very-Short-Moral-Stories-For-Kids-910x1024.jpg',
          },
        ),
      );

      // List<Map<String, Object?>> listStories = await _database.rawQuery(
      //     "SELECT * FROM ${DBConst.TABLE_STORYIES} ORDER BY createdAt desc");

      listCategory[0].listStories = listAllStories;

      return listCategory;
    } else {
      List<Map<String, Object?>> listCategoriesMap =
          await _database.query(DBConst.TABLE_CATRGORIES);

      List<Category> listCategories = listCategoriesMap
          .map((rowUserMap) => Category.fromMap(rowUserMap))
          .toList();

      for (int i = 0; i < listCategories.length; i++) {
        List<Map<String, Object?>> listStories = await _database.query(
            DBConst.TABLE_STORYIES,
            where: 'idCategory=?',
            whereArgs: [listCategories[i].id]);

        listCategories[i].listStories = listStories
            .map((rowUserMap) => Story.fromMapForCategoryId(rowUserMap))
            .toList();
      }

      listCategories.insert(
        0,
        Category.fromMapFromFirestore(
          {
            'docId': '0',
            'count': 0,
            'createdAt': DateTime.now().toString(),
            'updatedAt': DateTime.now().toString(),
            'name': 'كل القصص',
            'thumbnail':
                'https://cdn2.momjunction.com/wp-content/uploads/2015/08/Very-Short-Moral-Stories-For-Kids-910x1024.jpg',
          },
        ),
      );

      List<Map<String, Object?>> listStories = await _database.rawQuery(
          "SELECT * FROM ${DBConst.TABLE_STORYIES} ORDER BY createdAt ASC");

      listCategories[0].listStories = listStories
          .map((rowUserMap) => Story.fromMapForCategoryId(rowUserMap))
          .toList();

      return listCategories;
    }
  }

  Future<List<Story>> getListStoryFromCategory(String category_id) async {
    List<Story> listStories = [];
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestoreInstance.getStoriesFromCategory(category_id);
    for (int i = 0; i < data.docs.length; i++) {
      listStories.add(Story.fromQueryDocSnapshot(data.docs[i]));
    }
    return listStories;
  }

  @override
  Future<bool> updateLikesStory(
      String categoryId, String docId, int like) async {
    return await _firestoreInstance.updateStoryLikes(
        categoryId: categoryId, documentId: docId, like: like);
  }

  Future<File> getImageFileFromUrl(String urlImage) async {
    final http.Response responseData = await http.get(Uri.parse(urlImage));
    Uint8List uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  @override
  Future<bool> updateLikesFilm(int like) async {
    return await _firestoreInstance.updateFilmLikes(like: like);
  }
}
