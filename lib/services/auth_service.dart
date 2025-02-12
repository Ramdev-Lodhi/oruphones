import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  UserModel? currentUser;

  //  OTP Create (Login)
  Future<bool> sendOTP(String phoneNumber) async {
    try {
      int mobileNumber = int.parse(phoneNumber);
      Response? response = await _apiService.postRequest(
        "/login/otpCreate",
        {"countryCode": 91, "mobileNumber": mobileNumber},
      );

      if (response != null && response.statusCode == 200) {
        String status = response.data["status"];
        if (status == "SUCCESS") {
          print(
              "OTP Sent Successfully to +${response.data['dataObject']['mobileNumber']}");
          return true;
        } else {
          print("OTP Failed: ${response.data['reason']}");
          return false;
        }
      }
      return false;
    } catch (e) {
      print("Error in sendOTP: $e");
      return false;
    }
  }

  //  OTP Validate and User Data Fetch
  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    try {
      int mobileNumber = int.parse(phoneNumber);
      int OTP = int.parse(otp);
      Response? response = await _apiService.postRequest("/login/otpValidate",
          {"countryCode": 91, "mobileNumber": mobileNumber, "otp": OTP});

      if (response != null && response.statusCode == 200) {
        String status = response.data["status"];
        if (status == "SUCCESS") {
          currentUser = UserModel.fromJson(response.data["user"]);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("mobileNumber", currentUser!.mobileNumber);
          return true;
        }
      }
    } catch (e) {
      print("Error in verifyOTP: $e");
    }
    return false;
  }

  //  Get Current User from Local Storage
  Future<UserModel?> getCurrentUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? mobileNumber = prefs.getString("mobileNumber");

      if (mobileNumber != null && currentUser != null) {
        return currentUser;
      }
    } catch (e) {
      print("Error in getCurrentUser: $e");
    }
    return null;
  }

  //  Check if User is Logged In
  Future<bool> isLoggedIn() async {
    try {
      Response? response = await _apiService.getRequest("/isLoggedIn");
      return response != null && response.statusCode == 200;
    } catch (e) {
      print("Error in isLoggedIn: $e");
      return false;
    }
  }

  //  Update User Profile
  Future<bool> updateUserName(String name) async {
    try {
      Response? response =
          await _apiService.postRequest("/update", {"name": name});
      return response != null && response.statusCode == 200;
    } catch (e) {
      print("Error in updateUserName: $e");
      return false;
    }
  }

  //  Logout
  Future<bool> logout() async {
    try {
      Response? response = await _apiService.getRequest("/logout");
      if (response != null && response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("mobileNumber");
        currentUser = null;
        return true;
      }
    } catch (e) {
      print("Error in logout: $e");
    }
    return false;
  }
}
