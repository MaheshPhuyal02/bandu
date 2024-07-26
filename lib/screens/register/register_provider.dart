import 'package:flutter/material.dart';

import '../../services/ui_messages.dart';
import '../../services/user_manager.dart';

class RegisterProvider extends ChangeNotifier {

  bool showPassword = false;

  bool showPasswordC = false;

  bool loading = false;

  String? email, password, name;

  void toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }
  void toggleShowPasswordC() {
    showPasswordC = !showPasswordC;
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



  Future<void> register(BuildContext context) async {
    setLoading(context, true);
    await AuthManager.instance.register(
        name!,
        email!, password!);
    await Future.delayed(Duration(seconds: 1));
    setLoading(context, false);
    print("status : ${AuthManager.instance.status}");
    if(AuthManager.instance.status == AuthStatus.error) {
      UiMessages.showError(context, AuthManager.instance.getError());
    }
  }

}
