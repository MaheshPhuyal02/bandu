import 'package:bandu/main.dart';
import 'package:bandu/models/task/sub_task.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/task/task.dart';
import '../../../services/db_manager.dart';

class TaskDetailsProvider extends ChangeNotifier {
  Task? task;
  bool isTextEditable = false, isDescriptionEditable = false, isDeadlineEditable = false, isSubTaskEditable = false;

  final ConfettiController controllerCenter =
  ConfettiController(duration: const Duration(seconds: 1));

  TextEditingController textController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool showSublist = true;

  void init(Task task) {
    this.task = task;

    textController.text = task.title;

    descriptionController.text = task.description;

    notifyListeners();


  }

  Future<void> updateStatus(String status) async {
    task?.status = status;
    await DbManager.instance.updateTask(task!);
    notifyListeners();
    if(status == "done"){
      for(SubTask subTask in task!.subTask){
        if(subTask.status != "done"){
          updateSubStatus(subTask.id, "done");
        }
      }
    }
  }

  void setEditable(String type, bool value) {
    switch (type) {
      case "text":
        isTextEditable = value;
        break;
      case "description":
        isDescriptionEditable = value;
        break;
      case "deadline":
        isDeadlineEditable = value;
        break;
      case "subTask":
        isSubTaskEditable = value;
        break;
    }
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
              await DbManager.instance.deleteTask(id);
              Navigator.pop(context);
              notifyListeners();
            },
            child: Text("Delete"),
          ),
        ],
      );
    });
  }
  Future<void> deleteTask(
      BuildContext context,
      String id,
  {
    bool close = true
  }) async {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Delete Task"),
        content: Text("Are you sure you want to delete this task?"),
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
              Navigator.pop(context);
              await DbManager.instance.deleteTask(
                  task!.id
              );
              notifyListeners();
              if(close) {
                appRouter.maybePop();
              }
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

  void updateTitle(String value) {
    print("UPDATE TITLE");
    task?.title = value;
    DbManager.instance.updateTask(task!);
    notifyListeners();
  }

  void updateDescription() {
    print("UPDATE DESCRIPTION");
    task?.description = descriptionController.text;
    DbManager.instance.updateTask(task!);
    notifyListeners();
  }

  void showDeadlinePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: task!.deadline!.isAfter(DateTime.now()) ? task!.deadline : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {

        if(value.isBefore(DateTime.now())){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Deadline cannot be in the past"),
          ));
          return;
        }

        task?.deadline = value;
        DbManager.instance.updateTask(task!);
        notifyListeners();
      }
    });
  }


}
