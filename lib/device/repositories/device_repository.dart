


import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'media_repository.dart';
import 'persistent_device.dart';

class DeviceRepository {
  PersitentDevice _persistenciaDeviceRepository = new PersitentDevice();
   MediaRepository _mediaRepository = new MediaRepository();

   Future<String> getImagenDevice(ImageSource source) async {
    try {
      return await _mediaRepository.getImgDevice(source);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> saveIdUser(String idUser) async {
    try {
      return _persistenciaDeviceRepository.saveIdUser(idUser);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> saveNickname(String nickName) async {
    try {
      return _persistenciaDeviceRepository.saveNickname(nickName);
    } catch (e) {
      throw Exception(e);
    }
  }
   Future<void> setToken(String token) async {
    try {
      return _persistenciaDeviceRepository.saveToken(token);
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<String> getToken(String token) async {
    try {
      return _persistenciaDeviceRepository.getToken().toString();
    } catch (e) {
      throw Exception(e);
    }
  }
}
