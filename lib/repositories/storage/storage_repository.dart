import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:start_date/repositories/storage/base_storage_repository.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<void> uploadImage(XFile image) async {
    try {
      await storage.ref("user_1/${image.name}").putFile(
            File(image.path),
          );
    } catch (_) {}
  }
}
