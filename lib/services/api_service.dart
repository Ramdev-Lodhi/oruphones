import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://40.90.224.241:5000"));

  Future<Response?> postRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      print("Error in POST $endpoint: $e");
      return null;
    }
  }

  Future<Response?> getRequest(String endpoint) async {
    try {
      Response response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      print("Error in GET $endpoint: $e");
      return null;
    }
  }
}
