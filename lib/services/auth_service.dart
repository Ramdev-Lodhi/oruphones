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
          print("OTP Verified Successfully!");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool("isLoggedIn", true);
          await prefs.setString("mobileNumber", currentUser!.mobileNumber);
          await prefs.setString("userName", currentUser!.userName);
          await prefs.setString("joined_date", currentUser!.createdDate);

          return true;
        }
      }
    } catch (e) {
      print(" Error in verifyOTP: $e");
    }
    return false;
  }

  //  Get Current User from Local Storage
  Future<String?> getCurrentUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var currentUser = prefs.getString("userName") ?? " ";
      return currentUser;
    } catch (e) {
      print("Error in getCurrentUser: $e");
    }
    return null;
  }

  //  Check if User is Logged In
  Future<bool> isLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
      if (isLoggedIn) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error in isLoggedIn: $e");
    }
    return false;
  }

  //  Update User Profile
  Future<bool> updateUserName(String name) async {
    try {
      String csrfToken = '6caa630f-dbba-4c62-ac3e-922680cf493f';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("userName", name);
      Response response = await Dio().post(
        "http://40.90.224.241:5000/update",
        data: {"countryCode": 91, "name": name},
        options: Options(
          headers: {
            "X-Csrf-Token": csrfToken,
            "Content-Type": "application/json"
          },
        ),
      );
      String status = response.data["status"];
      if (status =="SUCCESS") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("userName", name);
        print("Name Updated Successfully");
        return true;
      }
    } catch (e) {
      print("Error in updateUserName: $e");
      return false;
    }
    return false;
  }

  //  Logout
  Future<bool> logout() async {
    try {
      Response? response = await _apiService.getRequest("/logout");
      bool isLoggedIn = response?.data["isLoggedIn"] ?? false;
      if (!isLoggedIn) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", false);
        await prefs.remove("mobileNumber");
        currentUser = null;
        print("User Logged Out Successfully!");
        return true;
      }
    } catch (e) {
      print("Error in logout: $e");
    }
    return false;
  }
}
