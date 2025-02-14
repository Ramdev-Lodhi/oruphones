import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://40.90.224.241:5000"));

  // Post Request with Cookies
  // Future<Response?> postRequest(String endpoint, Map<String, dynamic> data) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String sessionId = prefs.getString("sessionId") ?? "";
  //
  //     Response response = await _dio.post(
  //       endpoint,
  //       data: data,
  //       options: Options(
  //         headers: {
  //           "Cookie": "session=$sessionId",
  //           "Content-Type": "application/json"
  //         },
  //       ),
  //     );
  //
  //     // Store sessionId from response cookies
  //     if (response.headers.map.containsKey("set-cookie")) {
  //       String? setCookie = response.headers["set-cookie"]?.first;
  //       if (setCookie != null && setCookie.contains("session=")) {
  //         String newSessionId = setCookie.split(";").first.split("=").last;
  //         await prefs.setString("sessionId", newSessionId);
  //       }
  //     }
  //
  //     return response;
  //   } catch (e) {
  //     print("Error in POST $endpoint: $e");
  //     return null;
  //   }
  // }
  Future<Response?> postRequest(
      String endpoint,
      Map<String, dynamic> data, {
        Map<String, String>? headers, // New parameter for additional headers
      }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String sessionId = prefs.getString("sessionId") ?? "";

      Map<String, String> defaultHeaders = {
        "Cookie": "session=$sessionId",
        "Content-Type": "application/json",
      };

      if (headers != null) {
        defaultHeaders.addAll(headers); // Merge custom headers
      }

      Response response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: defaultHeaders),
      );

      // Store sessionId from response cookies
      if (response.headers.map.containsKey("set-cookie")) {
        String? setCookie = response.headers["set-cookie"]?.first;
        if (setCookie != null && setCookie.contains("session=")) {
          String newSessionId = setCookie.split(";").first.split("=").last;
          await prefs.setString("sessionId", newSessionId);
        }
      }

      return response;
    } catch (e) {
      print("Error in POST $endpoint: $e");
      return null;
    }
  }

  // Get Request with Cookies
  Future<Response?> getRequest(String endpoint) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String sessionId = prefs.getString("sessionId") ?? "";
      print(sessionId);
      Response response = await _dio.get(
        endpoint,
        options: Options(
          headers: {
            "Cookie": "session=$sessionId",
          },
        ),
      );
      return response;
    } catch (e) {
      print("Error in GET $endpoint: $e");
      return null;
    }
  }
}
