import 'package:bandu/ext/sizes_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeProvider extends ChangeNotifier {
  int selectedIndex = 0;
  bool showChat = false;
  bool animateChatIc = false;
  double x1 = 100.0,
      x2 = 200.0,
      y1 = 100.0,
      y2 = 200.0,
      x1Prev = 100.0,
      x2Prev = 200.0,
      y1Prev = 100.0,
      y2Prev = 100.0;

  void setIconCoordinates(double x1, double y1, double x2, double y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    hideChat();
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    hideChat();
    notifyListeners();
  }

  void hideChat() {
    showChat = false;
    notifyListeners();
  }

  void toggleChatView() {
    x1 = 100.pW - 20.sp;
    x2 = 0;
    y1 = 0;
    y2 = 0;
    showChat = !showChat;
    notifyListeners();
  }

  void animateChatIcon() {
    animateChatIc = true;
    notifyListeners();
  }
  void cancelChatIconAnimation() {
    animateChatIc = false;
    notifyListeners();
  }
}
