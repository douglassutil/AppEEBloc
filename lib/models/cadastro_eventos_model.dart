import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroEventosModel {

  final db = Firestore.instance;
  final storage = FirebaseStorage.instance;

  Future<String> _pickSaveImage( File imagem) async {
    StorageReference ref = storage.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
    StorageUploadTask uploadTask = ref.putFile(imagem);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future<File> getImage() async {
    File imagem = await ImagePicker.pickImage(source: ImageSource.gallery);
    return  imagem ;
  }
  
}