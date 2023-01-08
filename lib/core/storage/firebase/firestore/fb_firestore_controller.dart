import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stories_app/features/home/model/photo_friends_model.dart';
import 'package:stories_app/features/home/model/report_stories_model.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';

class FbFirestoreController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getMovieOfTheWeek() async {
    return await _fireStore.collection('others').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCategories() async {
    return await _fireStore.collection('categories').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPhotoFriends() async {
    return await _fireStore
        .collection('gallery')
        .orderBy('likes', descending: true)
        .where('status', isEqualTo: 'APPROVED')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getShareFriends() async {
    return await _fireStore
        .collection('shared-stories')
        .orderBy('createdAt', descending: true)
        .where('status', isEqualTo: 'APPROVED')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getStoriesFromCategory(
    String idCategory,
  ) async {
    return await _fireStore
        .collection('categories')
        .doc(idCategory)
        .collection('stories')
        .orderBy('createdAt', descending: true)
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getPageContct() async {
    return await _fireStore.collection('config').doc('contactus').get();
  }

  Future<bool> updateStoryLikes({
    required String categoryId,
    required String documentId,
    required int like,
  }) async {
    return await _fireStore
        .collection('categories')
        .doc(categoryId)
        .collection('stories')
        .doc(documentId)
        .update({
          'likes': like,
        })
        .then((value) => true)
        .catchError((error) {
          print(error);
          return false;
        });
  }

  Future<bool> updateFilmLikes({
    required int like,
  }) async {
    return await _fireStore
        .collection('others')
        .doc('movie-story')
        .update({
          'likes': like,
        })
        .then((value) => true)
        .catchError((error) {
          print(error);
          return false;
        });
  }

  Future<bool> updatePhotoFriendsLikes({
    required String documentId,
    required int like,
  }) async {
    return await _fireStore
        .collection('gallery')
        .doc(documentId)
        .update({
          'likes': like,
        })
        .then((value) => true)
        .catchError((error) {
          print(error);
          return false;
        });
  }

  Future<bool> updateShareFriendsLikes({
    required String documentId,
    required int like,
  }) async {
    return await _fireStore
        .collection('shared-stories')
        .doc(documentId)
        .update({
          'likes': like,
        })
        .then((value) => true)
        .catchError((error) {
          print(error);
          return false;
        });
  }

  Future<bool> createPhotoUser({required PhotoFriendsModel photo}) async {
    return await _fireStore
        .collection('gallery')
        .add(photo.toMap())
        .then((value) => true)
        .catchError((error) {
      print(error);
      return false;
    });
  }

  Future<bool> createShareUser({required ShareFriendsModel share}) async {
    return await _fireStore
        .collection('shared-stories')
        .add(share.toMap())
        .then((value) => true)
        .catchError((error) {
      print(error);
      return false;
    });
  }

  Future<bool> createReport({required ReportStoriesModel report}) async {
    return await _fireStore
        .collection('report-stories')
        .add(report.toMap())
        .then((value) => true)
        .catchError((error) {
      print(error);
      return false;
    });
  }
}
