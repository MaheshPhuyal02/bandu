import 'package:bandu/services/ui_messages.dart';
import 'package:bandu/services/user_manager.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool showPassword = false;

  bool loading = false;

  String? email, password;

  void toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void setLoading(BuildContext context, bool value) {
    loading = value;
    if(loading) {
      UiMessages.showLoading(context);
    } else {
      UiMessages.hideLoading(context);
    }
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    setLoading(context, true);
    await AuthManager.instance.loginWithEmailPass(email!, password!);
    await Future.delayed(Duration(seconds: 1));
    setLoading(context, false);
    print("status : " + AuthManager.instance.status.toString());
    if(AuthManager.instance.status == AuthStatus.error) {
      UiMessages.showError(context, AuthManager.instance.getError());
    }
  }
}
