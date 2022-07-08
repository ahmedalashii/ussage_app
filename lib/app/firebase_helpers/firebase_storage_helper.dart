import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

typedef UploadListener = void Function({
  required bool status,
  required TaskState taskState,
  String? message,
  Reference? reference,
});

/*
  * Reference >> Represents a reference to a Google Cloud Storage object. Developers can upload, download, and delete objects, as well as get/set object metadata.
*/
class FirebaseStorageHelper {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Future<void> uploadImage(
      {required File file, required UploadListener uploadListener}) async {
    UploadTask uploadTask = _firebaseStorage
        .ref("images/${DateTime.now()}_image.png")
        .putFile(file);
    uploadTask.snapshotEvents.listen((event) {
      // we can't return bool inside a void function (listen) >> so we have to use typedef
      if (event.state == TaskState.running) {
        uploadListener(status: false, taskState: event.state);
      } else if (event.state == TaskState.success) {
        uploadListener(
            status: true,
            taskState: event.state,
            reference: event.ref,
            message: "Image Uploaded Successfully.");
      } else if (event.state == TaskState.error) {
        uploadListener(
            status: false,
            taskState: event.state,
            message: "Uploading Image has been failed!, something went wrong!");
      }
    });
  }

  Future<List<Reference>> getImages() async {
    ListResult listResult = await _firebaseStorage.ref("images").listAll();
    if (listResult.items.isNotEmpty) {
      return listResult.items;
    }
    return [];
  }

  Future<bool> deleteImage({required String path}) async {
    // Deletes the object at this reference's location.
    return await _firebaseStorage
        .ref(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}
