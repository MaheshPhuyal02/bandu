import 'dart:io';

import 'package:bandu/constants/prompts.dart';
import 'package:bandu/services/db_manager.dart';
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

    _gemModel = GenerativeModel(
      model: _model,
      apiKey: _apiKey,
      systemInstruction: Content.system(
        Prompts.defaultSystem,
      ),
      tools: [
        Tool(functionDeclarations: [taskSchema])
      ],
    );
    status = GeminiStatus.ready;
  }

  Future<String> sendMessage(String message) async {
    if (status != GeminiStatus.ready) {
      throw Exception('Gemini is not ready');
    }

    message = message.trim();
    GenerateContentResponse? sendMessage =
        await _gemModel?.startChat(
          history: history,
        ).sendMessage(Content.text(message));

    _addToHistory(Content.text(message));
    _addToHistory(Content.model([
      TextPart(sendMessage!.text!),
    ]));
    String response = sendMessage.text!;

    return response;
  }

  Future<String> sendMessageWithCommand(String message, String command) async {
    if (status != GeminiStatus.ready) {
      throw Exception('Gemini is not ready');
    }

    message  = message.trim();

    _gemModel = GenerativeModel(
      model: _model,
      apiKey: _apiKey,
      systemInstruction: Content.system(
        Prompts.defaultSystem + command,
      ),
      tools: [
        Tool(functionDeclarations: [taskSchema, listTaskSchema])
      ],
    );
    var chat = _gemModel?.startChat(
      history: history,
    );
    status = GeminiStatus.ready;
    var response = await chat!.sendMessage(Content.text(message));

    final functionCalls = response.functionCalls.toList();
    if (functionCalls.isNotEmpty) {
      final functionCall = functionCalls.first;
      final result = switch (functionCall.name) {
        'addTask' => await addTask(functionCall.args),
        'addListTask' => await addListTask(functionCall.args),
        _ => throw UnimplementedError(
            'Function not implemented: ${functionCall.name}')
      };
      response = await chat!
          .sendMessage(Content.functionResponse(functionCall.name, result));
    }
    String r = response.text!;
    _addToHistory(Content.text(message));
    _addToHistory(Content.model([
      TextPart(r),
    ]));
    return r;
  }


  _addToHistory(Content content){

  //   max 10
    if(history.length > 10){
      history.removeAt(0);
    }
    history.add(content);
  }

  Future<Map<String, String>> addTask(Map<String, dynamic> data) async {
    try {
      print(
          "============================= Adding task ============================ : " +
              data.toString());

      final Task task = Task(
        title: data['title'],
        description: data['description'],
        createdDate: DateTime.now(),
        deadline: DateTime.parse(data['deadline']),
        completed: false,
        subTask: (data['subTask'] as List).map((subTask) {
          return SubTask(
            status: "pending",
            title: subTask['title'],
            description: subTask['description'],
            createdDate: DateTime.now(),
            deadline: DateTime.parse(subTask['deadline']),
            completed: false,
            taskId: DbManager.instance.generateId(),
          );
        }).toList(),
      );

      print("Task : " + task.toString());

      await DbManager.instance.addTask(task);

      return {"status": 'Task added successfully'};
    } catch (e) {
      return {"status": 'Error adding task'};
    }
  }


 Future<Map<String, String>> addListTask(Map<String, dynamic> data) async {
    try {
      print(
          "============================= Adding task List ============================ : " +
              data.toString());


      // final Task task = Task(
      //   title: data['title'],
      //   description: data['description'],
      //   createdDate: DateTime.now(),
      //   deadline: DateTime.parse(data['deadline']),
      //   completed: false,
      //   subTask: (data['subTask'] as List).map((subTask) {
      //     return SubTask(
      //       status: "pending",
      //       title: subTask['title'],
      //       description: subTask['description'],
      //       createdDate: DateTime.now(),
      //       deadline: DateTime.parse(subTask['deadline']),
      //       completed: false,
      //       taskId: DbManager.instance.generateId(),
      //     );
      //   }).toList(),
      // );
      //
      // print("Task : " + task.toString());
      //
      // await DbManager.instance.addTask(task);

      return {"status": 'Task added successfully'};
    } catch (e) {
      return {"status": 'Error adding task'};
    }
  }



  final listTaskSchema = FunctionDeclaration(
    'addTaskList',
    'Add a list of tasks with a list of subtasks.',
    Schema(SchemaType.array,
      items: Schema(SchemaType.object, properties: {
        'title': Schema(
          SchemaType.string,
          description: 'The title of the task.',
        ),
        'description': Schema(
          SchemaType.string,
          description: 'A detailed description of the task.',
        ),
        'deadline': Schema(
          SchemaType.string,
          description: 'The deadline for the task.',
        ),
        'completed': Schema(
          SchemaType.boolean,
          description: 'Indicates if the task is completed.',
        ),
        'subTasks': Schema(
          SchemaType.array,
          items: Schema(
            SchemaType.object,
            properties: {
              'title': Schema(
                SchemaType.string,
                description: 'The title of the subtask.',
              ),
              'description': Schema(
                SchemaType.string,
                description: 'A detailed description of the subtask.',
              ),
              'createdDate': Schema(
                SchemaType.string,
                description: 'The date and time when the subtask was created.',
              ),
              'deadline': Schema(
                SchemaType.string,
                description: 'The deadline for the subtask.',
              ),
              'completed': Schema(
                SchemaType.boolean,
                description: 'Indicates if the subtask is completed.',
              ),
              'taskId': Schema(
                SchemaType.string,
                description: 'The ID of the task to which this subtask belongs.',
              ),
            },
            requiredProperties: [
              'title',
              'description',
              'createdDate',
              'deadline',
              'completed',
              'taskId'
            ],
          ),
          description: 'A list of subtasks associated with the task.',
        ),
      },
          requiredProperties: [
            'title',
            'description',
            'createdDate',
            'deadline',
            'completed',
            'subTasks'
          ]),
    ),
  );

  final taskSchema = FunctionDeclaration(
      'addTask',
      'Represents a task with a list of subtasks.',
      Schema(SchemaType.object, properties: {
        'title':
            Schema(SchemaType.string, description: 'The title of the task.'),
        'description': Schema(SchemaType.string,
            description: 'A detailed description of the task.'),
        'createdDate': Schema(SchemaType.string,
            description: 'The date and time when the task was created.'),
        'deadline': Schema(SchemaType.string,
            description: 'The deadline for the task.'),
        'completed': Schema(SchemaType.boolean,
            description: 'Indicates if the task is completed.'),
        'subTask': Schema(SchemaType.array,
            items: Schema(SchemaType.object, properties: {
              'title': Schema(SchemaType.string,
                  description: 'The title of the subtask.'),
              'description': Schema(SchemaType.string,
                  description: 'A detailed description of the subtask.'),
              'createdDate': Schema(SchemaType.string,
                  description:
                      'The date and time when the subtask was created.'),
              'deadline': Schema(SchemaType.string,
                  description: 'The deadline for the subtask.'),
              'completed': Schema(SchemaType.boolean,
                  description: 'Indicates if the subtask is completed.'),
              'taskId': Schema(SchemaType.string,
                  description:
                      'The ID of the task to which this subtask belongs.'),
            }, requiredProperties: [
              'title',
              'description',
              'createdDate',
              'deadline',
              'completed',
              'taskId'
            ]),
            description:
                'A list of subtasks associated with the task.(List of objects)'),
      }, requiredProperties: [
        'title',
        'description',
        'createdDate',
        'deadline',
        'completed',
        'subTask'
      ]));

}

enum GeminiStatus {
  loading,
  ready,
  error,
}
