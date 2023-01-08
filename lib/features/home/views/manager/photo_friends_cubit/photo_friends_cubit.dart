// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:stories_app/core/storage/firebase/storage/fb_storage_controller.dart';
import 'package:stories_app/core/utils/helpers.dart';
import 'package:stories_app/features/home/data/photo_friends_repo_imp.dart';
import 'package:stories_app/features/home/model/photo_friends_model.dart';
import 'package:stories_app/features/home/views/manager/add_photo/add_photo_cubit.dart';

part 'photo_friends_state.dart';

class PhotoFriendsCubit extends Cubit<PhotoFriendsState> {
  List<PhotoFriendsModel> listPhoto = [];
  bool loading = true;
  bool loadingUploadImage = false;

  bool clickItemTheBestFriends = false;

  final _photo_repo_imp = PhotoFriendsRepoImp();

  PhotoFriendsCubit() : super(PhotoFriendsInitial());

  static PhotoFriendsCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  Future getPhotoFriends() async {
    listPhoto = await _photo_repo_imp.getPhotoFriends();
    loading = false;
    emit(GetPhotosFriends());
  }

  Future updateLikePhoto(int index) async {
    listPhoto[index].likes = listPhoto[index].likes! + 1;
    await _photo_repo_imp.updatePhotoFriendsLikes(
        listPhoto[index].docId!, listPhoto[index].likes ?? 0);
    emit(GetPhotosFriends());
  }

  Future<bool> createPhoto(
    BuildContext context, {
    required String name,
    required String country,
  }) async {
    if (AddPhotoCubit.get(context).image == null) {
      Helpers.showSnackBar(
        context,
        message: 'قم بإرفاق صورة',
        error: true,
      );
      return false;
    }
    loadingUploadImage = true;
    emit(GetPhotosFriends());

    String url = await FbStorageController()
        .uploadImage(AddPhotoCubit.get(context).image!);

    PhotoFriendsModel photo = photoModel(url, name, country);

    bool upload = await _photo_repo_imp.createPhotoFriend(photo);

    if (upload) {
      Helpers.showSnackBar(context, message: 'تمت العملية بنجاح');
    } else {
      Helpers.showSnackBar(
        context,
        message: 'حدثت عملية خطأ يرجي المحاولة فيما بعد',
        error: true,
      );
    }
    loadingUploadImage = false;

    emit(GetPhotosFriends());
    return upload;
  }

  clickItem() {
    clickItemTheBestFriends = !clickItemTheBestFriends;
    emit(OnClick());
  }

  PhotoFriendsModel photoModel(
    String urlFile,
    String name,
    String country,
  ) {
    return PhotoFriendsModel(
      file: urlFile,
      country: country,
      name: name,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      likes: 0,
      status: 'PENDING',
    );
  }
}
