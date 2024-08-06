import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../../models/task/task.dart';
import '../../../services/db_manager.dart';

class TaskDetailsProvider extends ChangeNotifier {
  Task? task;

  final ConfettiController controllerCenter =
  ConfettiController(duration: const Duration(seconds: 1));

  void init(Task task) {
    this.task = task;
  }

  Future<void> updateStatus(String status) async {
    task?.status = status;
    await DbManager.instance.updateTask(task!);
    notifyListeners();
  }

  Future<void> updateSubTask(String id, String status) async {
    task?.subTask.forEach((element) {
      if (element.id == id) {
        if (element.status != status) {
          if (status == 'done') {
            controllerCenter.play();
          }
          print('Status: ' + element.status);
          element.status = status;
          notifyListeners();
        }
      }
    });
    await DbManager.instance.updateTask(task!);
  }

}
