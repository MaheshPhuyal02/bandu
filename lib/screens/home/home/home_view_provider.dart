import 'package:bandu/models/task/task.dart';
import 'package:bandu/services/db_manager.dart';
import 'package:flutter/cupertino.dart';


class HomeViewProvider with ChangeNotifier {
  List<Task> taskList = [];

  void init() {
    DbManager.instance.streamRecentTasks().listen((event) {
      taskList.clear();
      taskList.addAll(event.docs.map((e) => Task.fromJson(e.data())).toList());
      print("HomeViewProvider ::: Tasks loaded :" + taskList.length.toString());
      notifyListeners();
    });
  }

}
