import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_app/main.dart';

Future<XFile?> getImageGallery() async {
  const compress = 30;
  final ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: compress,
  );
  return image;
}

Future<XFile?> getImageCamera() async {
  const compress = 30;
  final ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(
    source: ImageSource.camera,
    imageQuality: compress,
  );
  return image;
}

Future<void> upload(String path, String itemId) async {
  File file = File(path);
  try {
    String ref = 'images/${itemId}/img_${DateTime.now().toString()}.jpg';
    await fb.ref(ref).putFile(file);
  } on FirebaseException catch (e) {
    throw Exception('Erro no upload: ${e.code}');
  }
}

pickAndUploadImage(String itemId) async {
  XFile? file = await getImageGallery();
  if (file != null) {
    await upload(file.path, itemId);
  }
}
