import 'package:bandu/main.dart';
import 'package:bandu/services/db_manager.dart';
import 'package:bandu/services/ui_messages.dart';
import 'package:flutter/material.dart';

import '../../../models/task/sub_task.dart';
import '../../../models/task/task.dart';

class AddTaskProvider extends ChangeNotifier {
  String? taskTitle, taskDescription, subTitle, subDescription;

  DateTime selectedDate = DateTime.now().add(Duration(days: 2));
  DateTime selectedSubDate = DateTime.now().add(Duration(days: 1));

  Future<void> selectDate(
    BuildContext context, {
    bool subTask = false,
  }) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: subTask ? selectedSubDate : selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    DateTime s = subTask ? selectedSubDate : selectedDate;
    if (picked != null && picked != s) {
      if (subTask) {
        selectedSubDate = picked;
      } else {
        selectedDate = picked;
      }
      notifyListeners();
    }
  }

  Future<void> submit(BuildContext context) async {

    if(taskTitle == null || subTitle == null) {
      return;
    }

    if(selectedDate.isBefore(selectedSubDate)) {
      UiMessages.showError(context, "Sub Task deadline should be before Task deadline");
      return;
    }

    String id = DbManager.instance.generateId();
    Task task = Task(
        title: taskTitle!,
        description: taskDescription?? "",
        id: id,
        createdDate: DateTime.now(),
        deadline: selectedDate,
        updatedDate: DateTime.now(),
        status: "to_do",
        subTask: [
          SubTask(
            title: subTitle!,
            description: subDescription?? "",
            id: DbManager.instance.generateId(),
            createdDate: DateTime.now(),
            deadline: selectedSubDate,
            status: "to_do",
            updatedDate: DateTime.now(),
            taskId: id,
          )
        ]);
    await DbManager.instance.addTask(task);
    appRouter.maybePop();
  }
}
