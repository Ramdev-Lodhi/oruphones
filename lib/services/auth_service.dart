import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:oruphones/services/product_service.dart';
import 'package:oruphones/ui/views/home/home_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/app.locator.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  UserModel? currentUser;

  // Send OTP (Login)
  Future<bool> sendOTP(String phoneNumber) async {
    try {
      Response? response = await _apiService.postRequest(
        "/login/otpCreate",
        {"countryCode": 91, "mobileNumber": int.parse(phoneNumber)},
      );

      if (response != null &&
          response.statusCode == 200 &&
          response.data["status"] == "SUCCESS") {
        print(
            "OTP Sent Successfully to ${response.data['dataObject']['mobileNumber']}");
        return true;
      }
      return false;
    } catch (e) {
      print("Error in sendOTP: $e");
      return false;
    }
  }

  // Verify OTP and Fetch User Data
  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    try {
      Response? response = await _apiService.postRequest(
        "/login/otpValidate",
        {
          "countryCode": 91,
          "mobileNumber": int.parse(phoneNumber),
          "otp": int.parse(otp)
        },
      );

      if (response != null &&
          response.statusCode == 200 &&
          response.data["status"] == "SUCCESS") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (response.headers.map.containsKey("set-cookie")) {
          String? setCookie = response.headers["set-cookie"]?.first;
          if (setCookie != null && setCookie.contains("session=")) {
            String newSessionId = setCookie.split(";").first.split("=").last;
            await prefs.setString("sessionId", newSessionId);
            return true;
          }
        }
      }
    } catch (e) {
      print("Error in verifyOTP: $e");
    }
    return false;
  }

  // Check if User is Logged In
  Future<bool> isLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response? response = await _apiService.getRequest("/isLoggedIn");
      print(response);
      if (response != null &&
          response.statusCode == 200 &&
          response.data["isLoggedIn"] == true) {
        currentUser = UserModel.fromJson(response.data);
        print(currentUser?.userName);
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("csrfToken", jsonEncode(currentUser!.csrfToken));
        await prefs.setString("userData", jsonEncode(currentUser!.toJson()));
        return true;
      }
    } catch (e) {
      print("Error in isLoggedIn: $e");
    }
    return false;
  }

  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    String? userDataString = prefs.getString("userData");

    if (!isLoggedIn || userDataString == null) {
      return {"isLoggedIn": false};
    }

    Map<String, dynamic> userData = jsonDecode(userDataString);
    return {
      "isLoggedIn": true,
      "userName": userData["userName"] ?? "ORU User",
      "createdDate": userData["createdDate"] ?? "N/A",
    };
  }
  // Update User Name
  Future<bool> updateUserName(String name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response? response = await _apiService.postRequest(
        "/update",
        {"countryCode": 91, "userName": name},
        headers: {
          "X-CSRF-Token": "${currentUser?.csrfToken}",
        },
      );

      print(response);

      if (response?.statusCode == 200 &&
          response?.data["status"] == "SUCCESS") {
        await prefs.setString("userName", name);
        UserModel().userName = name;
        print("Name Updated Successfully");
        return true;
      }
      return false;
    } catch (e) {
      print("Error in updateUserName: $e");
    }
    return false;
  }
  List<ProductModel> productList = [];
  // Logout
  Future<bool> logout() async {
    try {
      Response? response = await _apiService.getRequest("/logout");
      if (response != null && response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
         currentUser = null;
         print(currentUser?.userName);
        productList.clear();
        print("User Logged Out Successfully!");
        return true;
      }
    } catch (e) {
      print("Error in logout: $e");
    }
    return false;
  }
}
