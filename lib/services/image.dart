import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> getImage(String tipo) async {
  try {
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(
      source: tipo == 'camera' ? ImageSource.camera : ImageSource.gallery,
      // imageQuality: 60
    );
    if (pickedFile == null) {
      return null;
    }
    return File(pickedFile.path);
  } catch (e) {
    print(e);
    return null;
  }
}
