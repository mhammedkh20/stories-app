import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FbStorageController {
  final Reference _fireStorageRef = FirebaseStorage.instance.ref();

  final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';

  Future<String> uploadImage(File image) async {
    final uploadTask = _fireStorageRef
        .child('images_friends/$imageName')
        .putFile(File(image.path));
    final taskSnapshot = await uploadTask.whenComplete(() => true);

    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<String> uploadFile(PlatformFile file) async {
    final uploadTask;
    if (file.extension == 'mp4') {
      uploadTask = _fireStorageRef.child('vedios/$imageName').putFile(
            File(file.path!),
          );
    } else {
      uploadTask = _fireStorageRef.child('audios/$imageName').putFile(
            File(file.path!),
          );
    }
    final taskSnapshot = await uploadTask.whenComplete(() => true);

    return await taskSnapshot.ref.getDownloadURL();
  }
}
