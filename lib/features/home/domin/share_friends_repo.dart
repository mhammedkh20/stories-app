import 'package:stories_app/features/home/model/report_stories_model.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';

abstract class ShareFriendsRepo {
  Future<List<ShareFriendsModel>> getShareFriends();
  Future<bool> updateShareFriendsLikes(String docId, int like);
  Future<bool> createShareFriends(ShareFriendsModel shareModel);

  Future<bool> createReport(ReportStoriesModel report);
}
