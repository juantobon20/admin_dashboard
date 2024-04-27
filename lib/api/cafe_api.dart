import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {

  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = 'http://localhost:8080/api';
    _dio.options.headers = {
      'x-token' : LocalStorage.prefs.getString('token') ?? ''
    };
  }

  static Future<dynamic> httpGet(String path) async {
    try {
      final resp = await _dio.get(path);
      return resp.data;
    } catch (e) {
      throw('Error en el GET');
    }
  }

  static Future<dynamic> post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(path, data: formData);
      return resp.data;
    } catch (e) {
      throw('Error en el POST');
    }
  }

  static Future<dynamic> put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } catch (e) {
      throw('Error en el PUT');
    }
  }

  static Future<dynamic> delete(String path) async {
    try {
      final resp = await _dio.delete(path);
      return resp.data;
    } catch (e) {
      throw('Error en el PUT');
    }
  }
}