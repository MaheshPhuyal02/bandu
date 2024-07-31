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

    // final chat = _gemModel?.startChat();
    // final prompt = 'Dim the lights so the room feels cozy and warm.';
    //
    // var response = await chat?.sendMessage(Content.text(prompt));
    //
    // final functionCalls = response?.functionCalls.toList();
    // if (functionCalls!.isNotEmpty) {
    //   final functionCall = functionCalls.first;
    //   final result = switch (functionCall.name) {
    //     'setLightValues' => await setLightValues(functionCall.args),
    //     _ => throw UnimplementedError(
    //         'Function not implemented: ${functionCall.name}')
    //   };
    //   response = await chat!
    //       .sendMessage(Content.functionResponse(functionCall.name, result));
    // }
    // if (response!.text case final text?) {
    //   print(text);
    // }
  }

  Future<Map<String, Object?>> setLightValues(
    Map<String, Object?> arguments,
  ) async {
    return {
      'brightness': arguments['brightness'],
      'colorTemperature': arguments['colorTemp'],
    };
  }

  final lightControlTool = FunctionDeclaration(
      'setLightValues',
      'Set the brightness and color temperature of a room light.',
      Schema(SchemaType.object, properties: {
        'brightness': Schema(SchemaType.number,
            description: 'Light level from 0 to 100. '
                'Zero is off and 100 is full brightness.'),
        'colorTemperature': Schema(SchemaType.string,
            description: 'Color temperature of the light fixture, '
                'which can be `daylight`, `cool` or `warm`.'),
      }, requiredProperties: [
        'brightness',
        'colorTemperature'
      ]));

  Future<String> sendMessage(String message) async {
    if (status != GeminiStatus.ready) {
      throw Exception('Gemini is not ready');
    }

    GenerateContentResponse? sendMessage =
        await _gemModel?.startChat().sendMessage(Content.text(message));

    String response = sendMessage!.text!;
    return response;
  }

  Future<String> sendMessageWithCommand(String message, String command) async {
    if (status != GeminiStatus.ready) {
      throw Exception('Gemini is not ready');
    }
    _gemModel = GenerativeModel(
      model: _model,
      apiKey: _apiKey,
      systemInstruction: Content.system(
        Prompts.defaultSystem + command,
      ),
      tools: [
        Tool(functionDeclarations: [lightControlTool])
      ],
    );
    var chat = _gemModel?.startChat();
    status = GeminiStatus.ready;
    var response = await chat!.sendMessage(Content.text(message));

    final functionCalls = response!.functionCalls.toList();
    if (functionCalls.isNotEmpty) {
      final functionCall = functionCalls.first;
      final result = switch (functionCall.name) {
        'addTask' => await addTask(functionCall.args),
        _ => throw UnimplementedError(
            'Function not implemented: ${functionCall.name}')
      };
      response = await chat!
          .sendMessage(Content.functionResponse(functionCall.name, result));
    }
    String r = response!.text!;
    return r;
  }

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
            taskId: "1",
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
}

enum GeminiStatus {
  loading,
  ready,
  error,
}
