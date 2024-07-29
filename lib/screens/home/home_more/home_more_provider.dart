import 'package:bandu/main.dart';
import 'package:bandu/services/user_manager.dart';
import 'package:flutter/material.dart';

import '../../../routes/app_router.gr.dart';

class Home_moreProvider extends ChangeNotifier {
  void logout(BuildContext context) {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _logout(context);
            },
            child: Text("Logout"),
          ),
        ],
      );
    });
  }

  _logout(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    AuthManager.instance.logout();
    appRouter.pushAndPopUntil(LoginRoute(), predicate: (Route<dynamic> route) { return false; });
  }

}
