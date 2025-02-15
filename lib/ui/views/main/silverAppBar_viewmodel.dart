import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';

class SilverAppBarViewModel extends BaseViewModel {
  final ScrollController scrollController;
  final ValueNotifier<double> titleOffsetNotifier = ValueNotifier(0.0);
  final ValueNotifier<bool> isScrolledNotifier = ValueNotifier(false);
  bool isLoggedIn = false;

  SilverAppBarViewModel(this.scrollController) {
    checkLoginStatus();
    scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final direction = scrollController.position.userScrollDirection;

    if (direction == ScrollDirection.reverse) {
      if (titleOffsetNotifier.value == 0.0) {
        titleOffsetNotifier.value = -50.0;
        isScrolledNotifier.value = true;
      }
    } else if (direction == ScrollDirection.forward) {
      if (titleOffsetNotifier.value == -50.0) {
        titleOffsetNotifier.value = 0.0;
        isScrolledNotifier.value = false;
      }
    }
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    notifyListeners();
  }

  void navigateToLogin() {
    locator<NavigationService>().clearStackAndShow(Routes.loginView);
  }

  @override
  void dispose() {
    scrollController.removeListener(_handleScroll);
    titleOffsetNotifier.dispose();
    super.dispose();
  }
}
