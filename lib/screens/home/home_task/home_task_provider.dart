import 'package:bandu/services/db_manager.dart';
import 'package:flutter/material.dart';

import '../../../models/task/task.dart';

class Home_todoProvider extends ChangeNotifier {
  List<Task> taskList = [];

  void init() {
    DbManager.instance.streamTasks().listen((event) {
      taskList = event.docs.map((e) => Task.fromJson(e.data())).toList();
      notifyListeners();
    });
  }


}
