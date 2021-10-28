import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import "package:dio/dio.dart";

class Client {
  static final Client _client = new Client._internal();

  factory Client() {
    return _client;
  }

  static Dio _dio = new Dio();

  void configureDio() {
    String basicAuth =
        'Basic Y2tfZGJjMDI5ZTA2ZWJmZTdmNjg5YjJmZTRiOGJkNzhjNWEyNzlhN2IxYjpjc180ODhjOTNjOTlhOTE3OTc4NzU4N2Y0NmIzYmIyNWZkYzNmYzdlZDBj';

    _dio.options
      ..baseUrl = 'https://retoburnerstack.megaplexstars.com/'
      ..connectTimeout = 15000 //5s
      ..receiveTimeout = 15000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        'common-header': 'xx',
        'authorization': basicAuth
      };
  }

  Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);

      return resp.data;
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el GET');
    }
  }

  Future httpGetQueryParameters(
    String path,
    Map<String, dynamic>? queryParameters,
  ) async {
    try {
      final resp = await _dio.get(path, queryParameters: queryParameters);
      if (resp.statusCode as int >= 400) {
        throw (resp.data["message"]);
      }
      return resp.data;
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el GET');
    }
  }

  Future post(String path, Map<String, dynamic> data) async {
    try {
      final resp = await _dio.post(path, data: data);
      if (resp.statusCode as int >= 400) {
        throw (resp.data["message"]);
      }
      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el POST');
    }
  }

  Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el PUT $e');
    }
  }

  Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el delete');
    }
  }
    Future deletePlus(String path, data) async {
   

    try {
      final resp = await _dio.delete(path+data, );
      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el delete');
    }
  }

  Future uploadFile(String path, Uint8List bytes) async {
    final formData =
        FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes)});

    try {
      final resp = await _dio.put(path, data: formData);

      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el PUT $e');
    }
  }

  Client._internal() {
    configureDio();
  }
}
