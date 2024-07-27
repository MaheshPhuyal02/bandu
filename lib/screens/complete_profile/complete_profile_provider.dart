import 'package:bandu/main.dart';
import 'package:bandu/routes/app_router.gr.dart';
import 'package:bandu/services/user_manager.dart';
import 'package:flutter/material.dart';

class Complete_profileProvider extends ChangeNotifier {
  int selected = 0;

  void setSelected(int index) {
    selected = index;
    notifyListeners();
  }

  void submit() {
    AuthManager.instance.updateWorkAs(
      workAs: selected == 0 ? "Freelancer" : "Employee",
    );
    appRouter.replace(HomeMainRoute());
  }

  void exit(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Are you sure?"),
        content: Text("You'll be logged out and will have to complete your profile later."),
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
              AuthManager.instance.logout();
              appRouter.replace(LoginRoute());
            },
            child: Text("Exit"),
          ),
        ],
      );
    });
  }
}
