import 'package:flutter/material.dart';

class Complete_profileProvider extends ChangeNotifier {

  int selected = 0;

  void setSelected(int index) {
    selected = index;
    notifyListeners();
  }



}
