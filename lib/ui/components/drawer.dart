import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../services/auth_service.dart';
import '../widgets/gridItem.dart';

class MainDrawer extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: FutureBuilder<Map<String, dynamic>>(
          future: _authService.getUserData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            bool isLoggedIn = snapshot.data!["isLoggedIn"];
            String userName = snapshot.data?["userName"] ?? "ORU User";
            String createdDate = snapshot.data?["createdDate"] ?? "N/A";

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: DrawerHeader(
                    decoration: BoxDecoration(color: Colors.grey.shade100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/logo/header logo.png', height: 32),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Icon(Icons.clear, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        isLoggedIn
                            ? ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Joined: $createdDate",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          onTap: () {},
                        )
                            : ElevatedButton(
                          onPressed: () {
                            locator<NavigationService>().clearStackAndShow(Routes.loginView);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text("Login/SignUp",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text("Sell Your Phone",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () async {
                      bool isLoggedOut = await _authService.logout();
                      if (isLoggedOut) {
                        locator<NavigationService>().clearStackAndShow(Routes.splashView);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Logout failed, please try again")),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 90),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  padding: EdgeInsets.all(16),
                  children: [
                    GridItem(icon: Icons.shopping_cart_checkout, label: 'How to Buy', color: Colors.black),
                    GridItem(icon: Icons.attach_money, label: 'How to Sell', color: Colors.black),
                    GridItem(icon: Icons.info_outline, label: 'About Us', color: Colors.black),
                    GridItem(icon: Icons.question_answer_outlined, label: 'FAQs', color: Colors.black),
                    GridItem(icon: Icons.privacy_tip, label: 'Privacy Policy', color: Colors.black),
                    GridItem(icon: Icons.assignment_return, label: 'Refund Policy', color: Colors.black),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

