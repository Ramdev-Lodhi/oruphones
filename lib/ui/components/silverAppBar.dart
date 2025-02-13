import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class SilverAppBar extends StatefulWidget {
  final VoidCallback onMenuTap;

  const SilverAppBar({required this.onMenuTap});

  @override
  _SilverAppBarState createState() => _SilverAppBarState();
}

class _SilverAppBarState extends State<SilverAppBar> {
  bool isLoggedIn = false; // Default false

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: widget.onMenuTap,
                child: Image.asset('assets/logo/menu.png', height: 32),
              ),
              SizedBox(width: 10),
              Image.asset('assets/logo/header logo.png', height: 32),
            ],
          ),
          Row(
            children: [
              const Text(
                'India',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const Icon(Icons.location_on_outlined, size: 25),
              SizedBox(width: 10),

              isLoggedIn
                  ? IconButton(
                icon: Icon(Icons.notifications, size: 28, color: Colors.black),
                onPressed: () {
                  // locator<NavigationService>().navigateTo(Routes.notificationView);
                },
              )
                  : ElevatedButton(
                onPressed: () {
                  locator<NavigationService>().clearStackAndShow(Routes.loginView);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6C018),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          height: 1,
        ),
      ),
    );
  }
}
