import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MediaRepository {
  
  Future<String> getImgDevice(ImageSource source) async {

    try {

      PickedFile? pickedFile = await ImagePicker().getImage(
      source: source,
      maxWidth: 900,
      maxHeight: 900,
      //imageQuality: 50
    );

    if (pickedFile == null) {
      throw Exception('Cancelado por usuario');
    } else {
      String img64 = (await _cropImage(pickedFile.path));
      return img64;
    }
      
    } catch (e) {
      throw Exception('Cancelado por usuario');
    }
    
  }

  /// Crop Image
  Future<String> _cropImage(filePath) async {

    
      File? file = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 900,
        maxHeight: 900,
        compressFormat:ImageCompressFormat.jpg,
        compressQuality: 30,
        iosUiSettings:IOSUiSettings(title: "Edita Imagen",doneButtonTitle: "Aceptar",cancelButtonTitle: "Cancelar")
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Edita Imagen",
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white));
            
         List<int> imageBytes = await file!.readAsBytes();
      String img64 = base64Encode(imageBytes);
      return img64;
      
    

  }
}
