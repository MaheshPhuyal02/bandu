import 'package:bandu/screens/guide/guide_screen.dart';
import 'package:bandu/services/SharedPref.dart';
import 'package:bandu/services/user_manager.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../routes/app_router.gr.dart';

class SplashProvider extends ChangeNotifier {
  SplashProvider() {
    Future.delayed(const Duration(seconds: 2), () {
      if (SharedPref.instance.getValue("showedGuide") == null ||
          SharedPref.instance.getValue("showedGuide") == false) {
        appRouter.replace(GuideRoute());
        return;
      }
      if (AuthManager.instance.hasLoggedIn()) {
        appRouter.replace(HomeMainRoute());
      } else {
        appRouter.replace(LoginRoute());
      }
    });
  }
}
