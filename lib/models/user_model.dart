import 'dart:convert';

class UserModel {
  static final UserModel _instance = UserModel._internal();

  factory UserModel() {
    return _instance;
  }

  UserModel._internal();
  String userName = "";
  String email = "";
  String profilePicPath = "";
  String city = "";
  String state = "";
  String mobileNumber = "";
  bool isAccountExpired = false;
  String createdDate = "";
  List<String> favListings = [];
  List<String> userListings = [];
  String userType = "";
  bool waOptIn = false;
  String sessionId = "";
  String csrfToken = "";

  // Factory Constructor for JSON Parsing
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel()
      ..userName = json["user"]["userName"] ?? ""
      ..email = json["user"]["email"] ?? ""
      ..profilePicPath = json["user"]["profilePicPath"] ?? ""
      ..city = json["user"]["city"] ?? ""
      ..state = json["user"]["state"] ?? ""
      ..mobileNumber = json["user"]["mobileNumber"] ?? ""
      ..isAccountExpired = json["user"]["isAccountExpired"] ?? false
      ..createdDate = json["user"]["createdDate"] ?? ""
      ..favListings = List<String>.from(json["user"]["favListings"] ?? [])
      ..userListings = List<String>.from(json["user"]["userListings"] ?? [])
      ..userType = json["user"]["userType"] ?? ""
      ..waOptIn = json["user"]["WAOptIn"] ?? false
      ..sessionId = json["sessionId"] ?? ""
      ..csrfToken = json["csrfToken"] ?? "";
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "email": email,
      "profilePicPath": profilePicPath,
      "city": city,
      "state": state,
      "mobileNumber": mobileNumber,
      "isAccountExpired": isAccountExpired,
      "createdDate": createdDate,
      "favListings": favListings,
      "userListings": userListings,
      "userType": userType,
      "WAOptIn": waOptIn,
      "sessionId": sessionId,
      "csrfToken": csrfToken,
    };
  }
}
