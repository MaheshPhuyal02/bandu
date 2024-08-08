import 'package:bandu/services/db_manager.dart';
import 'package:flutter/material.dart';

import '../../../models/task/task.dart';

class Home_todoProvider extends ChangeNotifier {
  List<Task> taskList = [];

  void init() {
    print("Home_todoProvider ::: init");
    DbManager.instance.streamTasks().listen((event) {
      taskList.clear();
      taskList.addAll(event.docs.map((e) => Task.fromJson(e.data())).toList());
      print("Home_todoProvider ::: Tasks loaded :" + taskList.length.toString());
      notifyListeners();
    });
  }
}
