import 'package:bandu/services/user_manager.dart';
import 'package:flutter/material.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  String? email;

  set setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  Future<void> reset(BuildContext c) async {

    await AuthManager.instance.resetPassword(email!);
    ScaffoldMessenger.of(c).showSnackBar(SnackBar(
      content: Text("Password reset email sent"),
    ));


  }

}
