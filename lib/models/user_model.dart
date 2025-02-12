class UserModel {
  final String userName;
  final String email;
  final String profilePicPath;
  final String city;
  final String state;
  final String mobileNumber;
  final bool isAccountExpired;
  final String createdDate;
  final List<String> favListings;
  final String userType;
  final bool waOptIn;
  final List<dynamic> userListings;

  UserModel({
    required this.userName,
    required this.email,
    required this.profilePicPath,
    required this.city,
    required this.state,
    required this.mobileNumber,
    required this.isAccountExpired,
    required this.createdDate,
    required this.favListings,
    required this.userType,
    required this.waOptIn,
    required this.userListings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'] ?? "",
      email: json['email'] ?? "",
      profilePicPath: json['profilePicPath'] ?? "",
      city: json['city'] ?? "",
      state: json['state'] ?? "",
      mobileNumber: json['mobileNumber'] ?? "",
      isAccountExpired: json['isAccountExpired'] ?? false,
      createdDate: json['createdDate'] ?? "",
      favListings: List<String>.from(json['favListings'] ?? []),
      userType: json['userType'] ?? "",
      waOptIn: json['WAOptIn'] ?? false,
      userListings: json['userListings'] ?? [],
    );
  }
}
