import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<dynamic> uploadFile(
    String filepath,
    String filename,
  ) async {
    File file = File(filepath);

    try {
      await storage.ref('pizza/$filename').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('pizza').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('Found files : $ref');
    });

    return results;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('pizza/$imageName').getDownloadURL();

    return downloadURL;
  }
}
