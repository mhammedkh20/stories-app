import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stories_app/core/storage/db/db_const.dart';
import 'package:stories_app/core/storage/db/db_provider.dart';
import 'package:stories_app/core/storage/firebase/firestore/fb_firestore_controller.dart';
import 'package:stories_app/features/home/domin/share_friends_repo.dart';
import 'package:stories_app/features/home/model/report_stories_model.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';

class ShareFriendsRepoImp extends ShareFriendsRepo {
  final _firestoreInstance = FbFirestoreController();
  Database _database = DBProvider().database;

  @override
  Future<List<ShareFriendsModel>> getShareFriends() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi) {
      List<ShareFriendsModel> listShare = [];
      QuerySnapshot<Map<String, dynamic>> data =
          await _firestoreInstance.getShareFriends();

      for (int i = 0; i < data.docs.length; i++) {
        listShare.add(ShareFriendsModel.fromQueryDocSnapshot(data.docs[i]));
      }
      await _database.delete(DBConst.TABLE_SHARE_FRIEND);

      for (int i = 0; i < listShare.length; i++) {
        await _database.insert(
            DBConst.TABLE_SHARE_FRIEND, listShare[i].toMapDB());
      }
      return listShare;
    } else {
      List<Map<String, Object?>> listMap =
          await _database.query(DBConst.TABLE_SHARE_FRIEND);

      return listMap
          .map((rowUserMap) => ShareFriendsModel.fromMap(rowUserMap))
          .toList();
    }
  }

  @override
  Future<bool> updateShareFriendsLikes(String docId, int like) async {
    return await _firestoreInstance.updateShareFriendsLikes(
      documentId: docId,
      like: like,
    );
  }

  @override
  Future<bool> createShareFriends(ShareFriendsModel shareModel) async {
    return await _firestoreInstance.createShareUser(share: shareModel);
  }

  @override
  Future<bool> createReport(ReportStoriesModel report) async {
    return await _firestoreInstance.createReport(report: report);
  }
}
