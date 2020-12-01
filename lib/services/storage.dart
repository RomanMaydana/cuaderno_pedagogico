import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

final String directoryPet = "petImage";

class Storage {
  Future<String> addImage(File image, {String directory = 'userImage'}) async {
    print(image.path + 'dddd');
    print(Path.basenameWithoutExtension(image.path));
    StorageReference reference = FirebaseStorage()
        .ref()
        .child(directory)
        .child(Path.basenameWithoutExtension(image.path));
    StorageUploadTask uploadTask = reference.putFile(image);
    print('entra hasta aqu');

    uploadTask.events.listen((event) {
      print(event.snapshot.totalByteCount);
      print(event.snapshot.bytesTransferred);
      print(event.type);
    }, onError: (e) {
      print('error');
    }, cancelOnError: true);

    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    print(url);
    return url;
  }

  Future<void> deleteFromUrl(String url) async {
    await FirebaseStorage().getReferenceFromUrl(url)
      ..delete();
  }
}
