import 'package:bandu/services/ui_messages.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool showPassword = false;

  bool loading = false;

  void toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void setLoading(BuildContext context, bool value) {
    loading = value;
    UiMessages.showLoading(context);
    notifyListeners();
  }

}
