import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stories_app/core/storage/firebase/firestore/fb_firestore_controller.dart';
import 'package:stories_app/features/home/domin/contect_repo.dart';

class ContactRepoImp extends ContactRepo {
  final _firestoreInstance = FbFirestoreController();

  @override
  Future<String> getContactPage() async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await _firestoreInstance.getPageContct();

    return data['html'];
  }
}
