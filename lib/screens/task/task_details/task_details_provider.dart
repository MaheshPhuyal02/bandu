import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../../models/task/task.dart';
import '../../../services/db_manager.dart';

class TaskDetailsProvider extends ChangeNotifier {
  Task? task;

  final ConfettiController controllerCenter =
  ConfettiController(duration: const Duration(seconds: 1));

  bool showSublist = false;

  void init(Task task) {
    this.task = task;
  }

  Future<void> updateStatus(String status) async {
    task?.status = status;
    await DbManager.instance.updateTask(task!);
    notifyListeners();
  }

  Future<void> updateSubStatus(String id, String status)async {
    task?.subTask.firstWhere((element) => element.id == id).status = status;
    DbManager.instance.updateTask(task!);
    notifyListeners();
  }

  Future<void> deleteSubTask(
      BuildContext context,
      String id) async {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Delete Sub Task"),
        content: Text("Are you sure you want to delete this sub task?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              task?.subTask.removeWhere((element) => element.id == id);
              await DbManager.instance.updateTask(task!);
              Navigator.pop(context);
              notifyListeners();
            },
            child: Text("Delete"),
          ),
        ],
      );
    });
  }

  void toggleSublist() {
    showSublist = !showSublist;
    notifyListeners();
  }


}
