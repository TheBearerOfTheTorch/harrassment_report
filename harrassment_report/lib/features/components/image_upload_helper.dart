import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadHelper{
  FirebaseStorage storage = FirebaseStorage.instance;

  Future uploadPhotoWeb(Uint8List? uploadBytes) async{
    //FilePickerResult? result;

    try{
      if (uploadBytes != null) {
        final storageRef = storage.ref().child('imageUploads');
        final UploadTask uploadTask = storageRef.putData(uploadBytes);

        final TaskSnapshot taskSnapshot = await uploadTask;
        final String downloadedURL = await taskSnapshot.ref.getDownloadURL();

        ///you can than upload the url to cloud firestore
        print(downloadedURL);
      } else {
        // User canceled the picker
      }
    }catch(e){
      print(e);
    }
  }

  Future<PickedFile?> uploadPhotoMobile() async{
    final picker = ImagePicker();

    try{
      File? image = (await picker.pickImage(source: ImageSource.gallery))
      as File?;
      final UploadTask uploadTask = storage.ref().child('imageUploads')
          .putFile(File(image!.path));
      final TaskSnapshot taskSnapshot = await uploadTask;

      var downloadedURL = await (await uploadTask.whenComplete(() => null))
          .ref
          .getDownloadURL();

      ///you can than upload the url to cloud firestore
      print(downloadedURL);

    }catch(e){
      print(e);
    }
    return null;
  }
}