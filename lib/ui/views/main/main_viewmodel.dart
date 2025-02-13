import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  int selectedIndex = 0;
  bool isBottomNavVisible = true;
  ScrollController scrollController = ScrollController();

  MainViewModel() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (isBottomNavVisible) {
          isBottomNavVisible = false;
          notifyListeners();
        }
      } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (!isBottomNavVisible) {
          isBottomNavVisible = true;
          notifyListeners();
        }
      }
    });
  }
  String? fcmToken;
  Future<void> fetchFcmToken() async {
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
      print("FCM Token: $fcmToken");
      notifyListeners();
    } catch (e) {
      print("Error fetching FCM Token: $e");
    }
  }
}
