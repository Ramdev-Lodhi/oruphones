import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../models/user_model.dart';

class MainDrawer extends StatelessWidget {
  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    if (!isLoggedIn) {
      return {"isLoggedIn": false};
    }

    return {
      "isLoggedIn": true,
      "userName": prefs.getString("userName") ?? "ORU User",
      "createdDate": prefs.getString("joined_date") ?? "N/A",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: FutureBuilder<Map<String, dynamic>>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            bool isLoggedIn = snapshot.data!["isLoggedIn"];
            String userName = snapshot.data?["userName"] ?? "Guest";
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
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      await prefs.setBool("isLoggedIn", false);
                      locator<NavigationService>().clearStackAndShow(Routes.loginView);
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
                    _gridItem(Icons.shopping_cart_checkout, 'How to Buy', Colors.black),
                    _gridItem(Icons.attach_money, 'How to Sell', Colors.black),
                    _gridItem(Icons.info_outline, 'About Us', Colors.black),
                    _gridItem(Icons.question_answer_outlined, 'FAQs', Colors.black),
                    _gridItem(Icons.privacy_tip, 'Privacy Policy', Colors.black),
                    _gridItem(Icons.assignment_return, 'Refund Policy', Colors.black),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _gridItem(IconData icon, String label, Color color) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: color),
          SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: color)),
        ],
      ),
    );
  }
}
