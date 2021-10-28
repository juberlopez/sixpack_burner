import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PersitentDevice {
  FlutterSecureStorage? _storage;

  static final PersitentDevice _instance = PersitentDevice._internal();

  factory PersitentDevice() {
    return _instance;
  }

  PersitentDevice._internal() {
    _storage = new FlutterSecureStorage();
  }

  Future<String?> getIdUser() async {
    return await _storage!.read(key: "IdUser");
  }

  Future<void> saveIdUser(String token) async {
    await _storage!.write(key: "IdUser", value: token);
  }

  Future<String?> getNickname() async {
    return await _storage!.read(key: "nickname");
  }

  Future<void> saveNickname(String nickName) async {
    await _storage!.write(key: "nickname", value: nickName);
  }

  Future<void> saveToken(String token) async {
    await _storage!.write(key: "token", value: token);
  }

  Future<String?> getToken() async {
    return await _storage!.read(key: "token");
  }

  Future<void> deleteToken() async {
    await _storage!.delete(key: "token");
  }

  Future<void> saveUser(String userModel) async {
    await _storage!.write(key: "userModel", value: userModel);
  }

  /*Future<String?> getUser() async {
    return await _storage!.read(key: "userModel");
  }

  Future<void> deleteUser(String userModel) async {
    await _storage!.delete(key: "userModel");
  }*/

  Future<void> setReporte(String reporte) async {
    await _storage!.write(key: "reporte", value: reporte);
  }

  Future<String?> getReporte() async {
    return await _storage!.read(key: "reporte");
  }

  Future<void> deleteReporte() async {
    await _storage!.delete(key: "reporte");
  }

  Future<void> setDietas(String reporte) async {
    await _storage!.write(key: "dietas", value: reporte);
  }

  Future<String?> getDietas() async {
    return await _storage!.read(key: "dietas");
  }

  Future<void> deleteDietas() async {
    await _storage!.delete(key: "dietas");
  }

  Future<void> setUser(String user) async {
    await _storage!.write(key: "user", value: user);
  }

  Future<String?> getUser() async {
    return await _storage!.read(key: "user");
  }

  

  Future<void> deleteUser() async {
    await _storage!.delete(key: "user");
  }

  Future<void> deleteData() async {
    await  _storage!.deleteAll();
  }

  Future<void> setState(String state) async {
    await _storage!.write(key: "state", value: state);
  }

  Future<String?> getState() async {
    return await _storage!.read(key: "state");
  }

  Future<void> deleteState() async {
    await _storage!.delete(key: "state");
  }

  Future<void> setNotificacion(bool notificacion) async {
    await _storage!.write(key: "notificacion", value: notificacion.toString());
  }

  Future<bool?> getnotificacion() async {
    try {
      String? not = await _storage!.read(key: "notificacion");
      return not == "true" ? true : false;
    } catch (e) {
      return false;
    }
  }

  Future<void> setEncuesta(String escuesta) async {
    await _storage!.write(key: "dietas", value: escuesta);
  }

  Future<String?> getEncuesta() async {
    return await _storage!.read(key: "dietas");
  }
  Future<void> setPupopReto() async {
    await _storage!.write(key: "pupop", value: "true");
  }

  Future<String?> getPupopReto() async {
    return await _storage!.read(key: "pupop");
  }
}
