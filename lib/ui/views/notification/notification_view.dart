import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'notification_viewmodel.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      onModelReady: (model) => model.requestNotificationPermission(context), // 🚀 Auto Call on Start
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Notifications")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Manage your Notifications", style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => model.requestNotificationPermission(context),
                  child: Text("Enable Notifications"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
