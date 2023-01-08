import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'add_photo_state.dart';

class AddPhotoCubit extends Cubit<AddPhotoState> {
  File? image;
  PlatformFile? file;
  AddPhotoCubit() : super(AddPhotoInitial());

  static AddPhotoCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  addPhoto(XFile xFile) {
    image = File(xFile.path);
    emit(AddPhoto());
  }

  addFile(PlatformFile file) {
    this.file = file;
    emit(AddPhoto());
  }
}
