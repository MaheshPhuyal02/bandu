import 'package:bandu/services/db_manager.dart';
import 'package:bandu/services/ui_messages.dart';
import 'package:bandu/services/user_manager.dart';
import 'package:flutter/material.dart';

import '../../models/user/user_project.dart';

class SelectProjectProvider extends ChangeNotifier {
  List<Project> projects = [];
  String? title;

  TextEditingController titleController = TextEditingController();

  void init() {
    projects.clear();
    notifyListeners();
    print("SelectProjectProvider ::: Initializing SelectProjectProvider");
    DbManager.instance.getProjects().then((value) {
      projects.addAll(value);
      notifyListeners();
    });
  }

  Future<void> _addProject(String title, BuildContext context) async {
    String id = DbManager.instance.generateId();
    Project project =
        Project(title: title, lastUpdated: DateTime.now(), id: id);
    bool success = await DbManager.instance.addProject(project, AuthManager.instance.getUser()!.uid);
    if(success) {
      UiMessages.showMessage(
          context,
          "Project added successfully");
      projects.add(project);
      notifyListeners();
    } else {
      UiMessages.showError(context, "Failed to add project");
    }
    init();
  }

  void addNewProject(BuildContext context) {
    if(titleController.text.isEmpty) return;
    print("Adding project");
    _addProject(titleController.text, context);
  }

  void deleteProject(BuildContext context, int index) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Delete Project"),
        content: Text("Are you sure you want to delete this project?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteProject(index, context);
            },
            child: Text("Delete"),
          ),
        ],
      );
    });
  }

  void _deleteProject(int index, BuildContext context) {
    Project project = projects[index];
    DbManager.instance.deleteProject(project.id, AuthManager.instance.getUser()!.uid).then((value) {
      init();
      if(value) {
        UiMessages.showMessage(context, "Project deleted successfully");

      } else {
        UiMessages.showError(context, "Failed to delete project");
      }
    });
  }


}
