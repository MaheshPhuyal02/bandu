import 'dart:developer';
import 'dart:io';

import 'package:bandu/constants/prompts.dart';
import 'package:bandu/models/chat/message.dart';
import 'package:bandu/models/user/user_project.dart';
import 'package:bandu/services/db_manager.dart';
import 'package:bandu/services/user_manager.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../models/task/sub_task.dart';
import '../models/task/task.dart';

class GeminiManager {
//  instance
  static final GeminiManager instance = GeminiManager._internal();

  factory GeminiManager() => instance;

  GeminiManager._internal();

  final String _apiKey = "AIzaSyCG7r-tzU5cwfqDftlaejwm0KjUfnbSadA";
  final String _model = 'gemini-1.5-flash';

  GeminiStatus status = GeminiStatus.loading;

  GenerativeModel? _gemModel;

  List<Content> history = [];

  Future<void> init() async {
    if (_apiKey == null) {
      status = GeminiStatus.error;
      throw Exception('API_KEY is not set');
    }
    String user = await userInfo();
    _gemModel = _getGemModel(Prompts.defaultSystem + user);
    status = GeminiStatus.ready;
  }

  Future<String> userInfo() async {
    if (!AuthManager.instance.hasLoggedIn()) {
      return Future.value("");
    }
    if (AuthManager.instance.getUser()!.projects == null ||
        AuthManager.instance.getUser()!.projects!.isEmpty) {
      return Future.value("");
    }

    Project? project = await DbManager.instance.getCurrentProject();

    String platform;
    String projectTitle;

    if (project != null) {
      platform = project.projectPlatform ?? "No platform";
      projectTitle = project.title;
    } else {
      platform = "No platform";
      projectTitle = "No project";
    }

    return "and user project is : " +
        projectTitle +
        " and user project platform : " +
        platform;
  }

  Future<String> sendMessage(String message) async {
    if (status != GeminiStatus.ready) {
      throw Exception('Gemini is not ready');
    }

    message = message.trim();
    GenerateContentResponse? sendMessage = await _gemModel
        ?.startChat(
          history: history,
        )
        .sendMessage(Content.text(message));

    String? response = sendMessage?.text!;
    return response!;
  }

  Future<String> sendMessageWithCommand(String message, String command) async {
    if (status != GeminiStatus.ready) {
      throw Exception('Gemini is not ready');
    }

    message = message.trim();

    String user = await userInfo();

    _gemModel = _getGemModel(Prompts.defaultSystem + command + user);

    var chat = _gemModel?.startChat(
      history: history,
    );
    status = GeminiStatus.ready;
    try {
      var response = await chat!.sendMessage(Content.text(message));

      final functionCalls = response.functionCalls.toList();
      if (functionCalls.isNotEmpty) {
        final functionCall = functionCalls.first;
        final result = switch (functionCall.name) {
          'addTask' => await addTask(functionCall.args),
          'deleteAllTask' => await deleteAllTask(functionCall.args),
          'addTaskList' => await addListTask(functionCall.args),
          'getTaskList' => await getTaskList(functionCall.args),
          'updateTask' => await updateTask(functionCall.args),
          _ => throw UnimplementedError(
              'Function not implemented: ${functionCall.name}')
        };
        response = await chat
            .sendMessage(Content.functionResponse(functionCall.name, result));
      }

      return response.text!;
    } catch (e) {
      print("Error : " + e.toString());
      _gemModel = null;
      return "Error : " + e.toString();
    }
  }

  addToHistory(String message, String r) {
    _addToHistory(Content.text(message));
    _addToHistory(Content.model([
      TextPart(r),
    ]));
  }

  _getGemModel(system) {
    return GenerativeModel(
      model: _model,
      apiKey: _apiKey,
      systemInstruction: Content.system(
        system,
      ),
      tools: [
        Tool(functionDeclarations: [
          Prompts.taskSchema,
          Prompts.taskListSchema,
          Prompts.deleteAllTaskSchema,
          Prompts.getTaskList,
          Prompts.updateTask,
        ]),
      ],
    );
  }

  _addToHistory(Content content) {
    if (history.length > 10) {
      history.removeAt(0);
    }
    history.add(content);
  }

  Future<Map<String, String>> updateTask(Map<String, dynamic> data) async {
    try {
      print(
          "============================= Updating task ============================ : ");

      print("Data : " + data.toString());

      String valueType = data['valueType'];
      String value = data['value'];
      String taskId = data['taskId'];
      String type = data['taskType'];

      if (type == "task") {
        Task? task = await DbManager.instance.getTask(taskId);
        if (valueType == 'status') {
          task!.status = value;
        } else if (valueType == 'title') {
          task!.title = value;
        } else if (valueType == 'description') {
          task!.description = value;
        } else if (valueType == 'deadline') {
          task!.deadline = DateTime.parse(value);
        }

        await DbManager.instance.updateTask(task!);

        return {"status": 'Task updated successfully'};
      } else {
        print("Updating subtask");
        String subTaskId = data['subTaskId'];

        List<Task> tasks = await DbManager.instance.getTasks();

        print("Tasks : " + tasks.map((e) => e.toJson()).toList().toString());

        Task task = tasks.firstWhere((element) => element.id == taskId);

        SubTask? subTask =
            task.subTask.firstWhere((element) => element.id == subTaskId);

        if (valueType == 'status') {
          subTask.status = value;
        } else if (valueType == 'title') {
          subTask.title = value;
        } else if (valueType == 'description') {
          subTask.description = value;
        } else if (valueType == 'deadline') {
          subTask.deadline = DateTime.parse(value);
        }

        await DbManager.instance.updateSubTask(taskId, subTaskId, task.subTask);

        return {"status": 'SubTask updated successfully'};
      }
    } catch (e) {
      print("Error updating task : " + e.toString());

      return Future.value({"status": 'Error updating task'});
    }
  }

  Future<Map<String, dynamic>> getTaskList(Map<String, dynamic> data) async {
    try {
      print(
          "============================= Getting task list ============================ : ");

      List<Task> tasks = await DbManager.instance.getTasks();

      return {
        "taskList": [
          for (var task in tasks)
            {
              'title': task.title,
              'description': task.description,
              'id': task.id,
              'createdDate': task.createdDate.toString(),
              'deadline': task.deadline.toString(),
              'updatedDate': task.updatedDate.toString(),
              'status': task.status,
              'subTask': [
                for (var subTask in task.subTask)
                  {
                    'title': subTask.title,
                    'description': subTask.description,
                    'createdDate': subTask.createdDate.toString(),
                    'deadline': subTask.deadline.toString(),
                    'updatedDate': subTask.updatedDate.toString(),
                    'taskId': subTask.taskId,
                    'id': subTask.id,
                    'status': subTask.status,
                  }
              ]
            }
        ]
      };
    } catch (e) {
      print("Error getting task list : " + e.toString());
      return {"status": 'Error getting task list : Error :' + e.toString()};
    }
  }

  Future<Map<String, String>> deleteAllTask(Map<String, dynamic> data) async {
    try {
      print(
          "============================= Deleting all task ============================ : ");

      await DbManager.instance.deleteAllTask();

      return {"status": 'All tasks deleted successfully'};
    } catch (e) {
      return {"status": 'Error deleting all tasks'};
    }
  }

  Future<Map<String, String>> addTask(Map<String, dynamic> data) async {
    try {
      print(
          "============================= Adding task ============================ : ");

      print("Data : " + data["deadline"].runtimeType.toString());

      String id = DbManager.instance.generateId();

      final Task task = Task(
        id: id,
        title: data['title'],
        description: data['description'],
        createdDate: DateTime.now(),
        deadline: DateTime.parse(data['deadline']),
        updatedDate: DateTime.now(),
        status: "to_do",
        subTask: (data['subTask'] as List).map((subTask) {
          return SubTask(
            id: DbManager.instance.generateId(),
            status: "to_do",
            title: subTask['title'],
            description: subTask['description'],
            createdDate: DateTime.now(),
            deadline: DateTime.parse(subTask['deadline']),
            updatedDate: DateTime.now(),
            taskId: id,
          );
        }).toList(),
      );

      print("Task : " + task.toString());

      await DbManager.instance.addTask(task);

      return {"status": 'Task added successfully'};
    } catch (e) {
      print("Error adding task : " + e.toString());
      return {"status": 'Error adding task ' + e.toString()};
    }
  }

  Future<Map<String, String>> addListTask(Map<String, dynamic> data) async {
    try {
      print(
          "============================= Adding task List ============================ : ");

      log("Data : " + data.toString());

      for (Map<String, dynamic> task in data['tasks']) {
        String id = DbManager.instance.generateId();

        final Task t = Task(
          id: id,
          title: task['title'],
          description: task['description'],
          createdDate: DateTime.now(),
          deadline: DateTime.parse(task['deadline']),
          updatedDate: DateTime.now(),
          status: "to_do",
          subTask: (task['subTask'] as List).map((subTask) {
            return SubTask(
              id: DbManager.instance.generateId(),
              status: "to_do",
              title: subTask['title'],
              description: subTask['description'],
              createdDate: DateTime.now(),
              deadline: DateTime.parse(subTask['deadline']),
              updatedDate: DateTime.now(),
              taskId: id,
            );
          }).toList(),
        );

        print("Task : " + task.toString());

        await DbManager.instance.addTask(t);
      }
      return {"status": 'Task added successfully'};
    } catch (e) {
      return {"status": 'Error adding task'};
    }
  }

  void initHistory(List<Message> messageList) {
    messageList.map((e) {
      _addToHistory(Content.text(e.request));
      _addToHistory(Content.model([
        TextPart(e.response!),
      ]));
    }).toList();
  }
}

enum GeminiStatus {
  loading,
  ready,
  error,
}
