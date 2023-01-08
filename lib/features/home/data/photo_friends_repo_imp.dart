import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stories_app/core/storage/db/db_const.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/storage/firebase/firestore/fb_firestore_controller.dart';
import 'package:stories_app/features/home/domin/photo_friends_repo.dart';
import 'package:stories_app/features/home/model/photo_friends_model.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';

class PhotoFriendsRepoImp extends PhotoFriendsRepo {
  final _firestoreInstance = FbFirestoreController();
  Database _database = DBProvider().database;

  @override
  Future<List<PhotoFriendsModel>> getPhotoFriends() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi) {
      List<PhotoFriendsModel> listPhotoFriends = [];
      QuerySnapshot<Map<String, dynamic>> data =
          await _firestoreInstance.getPhotoFriends();

      for (int i = 0; i < data.docs.length; i++) {
        listPhotoFriends
            .add(PhotoFriendsModel.fromQueryDocSnapshot(data.docs[i]));
      }
      await _database.delete(DBConst.TABLE_PHOTO_FRIEND);

      for (int i = 0; i < listPhotoFriends.length; i++) {
        await _database.insert(
            DBConst.TABLE_PHOTO_FRIEND, listPhotoFriends[i].toMapDB());
      }

      return listPhotoFriends;
    } else {
      List<Map<String, Object?>> listMap =
          await _database.query(DBConst.TABLE_PHOTO_FRIEND);

      return listMap
          .map((rowUserMap) => PhotoFriendsModel.fromMap(rowUserMap))
          .toList();
    }
  }

  @override
  Future<bool> updatePhotoFriendsLikes(String docId, int like) async {
    return await _firestoreInstance.updatePhotoFriendsLikes(
        documentId: docId, like: like);
  }

  @override
  Future<bool> createPhotoFriend(PhotoFriendsModel photo) async {
    return await _firestoreInstance.createPhotoUser(photo: photo);
  }
}
