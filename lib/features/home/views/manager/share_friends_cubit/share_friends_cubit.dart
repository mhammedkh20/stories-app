import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stories_app/core/storage/firebase/storage/fb_storage_controller.dart';
import 'package:stories_app/core/storage/pref/shared_pref_controller.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/features/home/data/share_friends_repo_imp.dart';
import 'package:stories_app/features/home/model/report_stories_model.dart';
import 'package:stories_app/features/home/model/share_friends_model.dart';
import 'package:stories_app/features/home/model/username.dart';
import 'package:stories_app/features/home/views/manager/add_photo/add_photo_cubit.dart';

part 'share_friends_state.dart';

class ShareFriendsCubit extends Cubit<ShareFriendsState> {
  List<ShareFriendsModel> listShare = [];
  bool loading = true;
  bool loadingUploadData = false;

  List<String> listTypeReport = [
    'ابلاغ عن المحتوى',
    'ابلاغ عن المستخدم',
  ];

  String typeReport = 'ابلاغ عن المحتوى';

  // ! zero vedio
  // ! one Audio
  int vedioOrAudio = -1;

  final _share_repo_imp = ShareFriendsRepoImp();

  ShareFriendsCubit() : super(ShareFriendsInitial());

  static ShareFriendsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  Future getShareFriends() async {
    listShare = await _share_repo_imp.getShareFriends();
    List<ShareFriendsModel> listNewData = [];
    String? listDataMap = SharedPrefController().getListUserBan;

    if (listDataMap != null) {
      print("object ${listDataMap}");
      List<Username> listUsersBan = Username.decode(listDataMap);
      for (int i = 0; i < listShare.length; i++) {
        for (int j = 0; j < listUsersBan.length; j++) {
          if (listShare[i].name != listUsersBan[j].name) {
            listNewData.add(listShare[i]);
          }
        }
      }
    }

    if (listNewData.length != 0) {
      listShare.clear();
      listShare.addAll(listNewData);
    }

    listShare.addAll(listNewData);

    loading = false;
    emit(GetShareFriends());
  }

  Future changeTypeReport(String type) async {
    typeReport = type;
    emit(GetShareFriends());
  }

  updateLikeShare({
    required int index,
  }) async {
    listShare[index].likes = listShare[index].likes! + 1;

    await _share_repo_imp.updateShareFriendsLikes(
        listShare[index].docId!, listShare[index].likes ?? 0);

    emit(GetShareFriends());
  }

  void selectedVedioOrAudio(int index) {
    vedioOrAudio = index;
    emit(GetShareFriends());
  }

  Future<bool> uploadStoryWithFriends(
    BuildContext context, {
    required String name,
    required String country,
    required String titleStory,
    required String descStory,
  }) async {
    if (AddPhotoCubit.get(context).image == null) {
      Helpers.showSnackBar(
        context,
        message: 'قم بإرفاق صورة',
        error: true,
      );
      return false;
    }
    loadingUploadData = true;
    emit(GetShareFriends());

    String url = await FbStorageController()
        .uploadImage(AddPhotoCubit.get(context).image!);

    String? file;
    if (AddPhotoCubit.get(context).file != null) {
      file = await FbStorageController()
          .uploadFile(AddPhotoCubit.get(context).file!);
    }

    bool uploaded = await _share_repo_imp.createShareFriends(
      ShareFriendsModel(
        audioUrl: null,
        url: null,
        country: country,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        status: 'PENDING',
        title: titleStory,
        name: name,
        description: descStory,
        likes: 0,
        file: file,
        thumbnail: url,
      ),
    );
    if (uploaded) {
      Helpers.showSnackBar(context, message: 'تمت العملية بنجاح');
    } else {
      Helpers.showSnackBar(
        context,
        message: 'حدثت عملية خطأ يرجي المحاولة فيما بعد',
        error: true,
      );
    }
    loadingUploadData = false;
    emit(GetShareFriends());
    return uploaded;
  }

  Future<bool> createReport(
    BuildContext context, {
    required String reportUserOrContent,
    required String titleStory,
    required String docId,
    required String username,
    required String details,
  }) async {
    loadingUploadData = true;
    emit(GetShareFriends());

    bool uploaded = await _share_repo_imp.createReport(
      ReportStoriesModel(
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        type: reportUserOrContent,
        storyTitle: titleStory,
        storyId: docId,
        username: username,
        details: details,
      ),
    );
    if (uploaded) {
      Helpers.showSnackBar(context, message: 'تمت العملية بنجاح');
    } else {
      Helpers.showSnackBar(
        context,
        message: 'حدثت عملية خطأ يرجي المحاولة فيما بعد',
        error: true,
      );
    }
    loadingUploadData = false;
    emit(GetShareFriends());
    return uploaded;
  }

  void banUser(String username) {
    List<ShareFriendsModel> newlistShare = [];
    for (int i = 0; i < listShare.length; i++) {
      if (listShare[i].name != username) {
        newlistShare.add(listShare[i]);
      }
    }
    listShare = newlistShare;

    String? listUserBan = SharedPrefController().getListUserBan;

    List<Username> listUsers = [];

    Username userBand = Username(name: username);

    if (listUserBan == null) {
      listUsers.add(userBand);
    } else {
      listUsers.addAll(Username.decode(listUserBan));
      listUsers.add(userBand);
    }

    String dataMap = Username.encode(listUsers);
    SharedPrefController().setListUserBan(dataMap);
    emit(GetShareFriends());
  }
}
