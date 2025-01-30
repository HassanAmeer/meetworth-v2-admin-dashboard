import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FireStorageServices {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadPic(String folder, XFile image) async {
    String link = "";
    try {
      Reference ref =
          storage.ref().child("images/$folder/${DateTime.now().toString()}");
      UploadTask uploadTask = ref.putData(await image.readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'));
      var res = await uploadTask;
      link = await res.ref.getDownloadURL();
    } catch (_) {
      log(_.toString());
    }
    return link;
  }

  Future<bool> deletePic(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      return true;
    } catch (e) {
      log("Error deleting db from cloud: $e");
      return false;
    }
  }
}
