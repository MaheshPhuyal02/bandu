import 'package:bandu/services/db_manager.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/task/sub_task.dart';

class HomeViewProvider with ChangeNotifier {
  List<SubTask> taskList = [];

  void init() {
    DbManager.instance.streamRecentTasks().listen((event) {
      taskList.clear();
      taskList
          .addAll(event.docs.map((e) => SubTask.fromJson(e.data())).toList());
      print("HomeViewProvider ::: Tasks loaded :" + taskList.length.toString());
      notifyListeners();
    });
  }

  void updateSubStatus(String id, String taskId, String s) {
    SubTask subTask = taskList.firstWhere((element) => element.id == id);
    subTask.status = s;
    DbManager.instance.updateSubTask(id, taskId, [subTask]);
    notifyListeners();
  }
}
