import 'package:stories_app/features/home/model/photo_friends_model.dart';

abstract class PhotoFriendsRepo {
  Future<List<PhotoFriendsModel>> getPhotoFriends();

  Future<bool> updatePhotoFriendsLikes(String docId, int like);

  Future<bool> createPhotoFriend(PhotoFriendsModel frind);
}
