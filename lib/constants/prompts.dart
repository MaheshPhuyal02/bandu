import 'package:google_generative_ai/google_generative_ai.dart';

class Prompts {
  static const dateFormat = "yyyy-MM-dd";
  static const String defaultSystem =
      "Your name is TaskGen AI, You've been designed, developed and created by TaskGen Team. "
              "your task is to chat, analyze"
              " requirements, create task, delete tasks, analyze budget, analyze time, and summarize."
              " Be respectful, use professional language, and give short and sweet response."
              " Focus more on task generating, and less on chatting. "
              "Remember date format : " +
          dateFormat;

  static const String summarizeSystem =
      "Summarize the long message sent by user, send with format, and summarize in points."
              "Remember date format : " +
          dateFormat;

  static const String createTask =
      "Add task list as needed, call addTask function for single task "
              "and addTaskList for multiple task, with title, description, created date, deadline and subTask(list of subtasks) with title, description, deadline. Don't ask too many questions just add task as needed."
              "Remember date format : " +
          dateFormat;

  static const String analyzeRequirements =
      "Only analyze the requirements, study feasibility, make summary, budget, and so on. Only create task when user asks."
              "Remember date format : " +
          dateFormat;

  static const String analyzeBudget =
      "Analyze the budget, give overall budget, and breakdown in different task."
              "Remember date format : " +
          dateFormat;

  static const String analyzeTime =
      "Analyze the time, give overall time, and breakdown in different task."
              "Remember date format : " +
          dateFormat;

  static final deleteAllTaskSchema = FunctionDeclaration(
      "deleteAllTask",
      "Delete all tasks",
      Schema(SchemaType.object, properties: {
        'status': Schema(SchemaType.string,
            description: 'The status of delete system.'),
      }, requiredProperties: [
        "status"
      ]));

  static final taskListSchema = FunctionDeclaration(
      "addTaskList",
      "Add list of task with subtask list for each",
      Schema(SchemaType.object, properties: {
        'tasks': Schema(
          SchemaType.array,
          items: Schema(SchemaType.object, properties: {
            'title': Schema(SchemaType.string,
                description: 'The title of the task.'),
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
          ]),
          description:
              'A list of tasks with subtasks associated with each task.(List of objects)',
        ),
      }, requiredProperties: [
        'tasks',
      ]));

  //
  // Schema(SchemaType.array,
  //     items: Schema(SchemaType.object, properties: {
  //       'title': Schema(SchemaType.string,
  //           description: 'The title of the task.'),
  //       'description': Schema(SchemaType.string,
  //           description: 'A detailed description of the task.'),
  //       'createdDate': Schema(SchemaType.string,
  //           description: 'The date and time when the task was created.'),
  //       'deadline': Schema(SchemaType.string,
  //           description: 'The deadline for the task.'),
  //       'completed': Schema(SchemaType.boolean,
  //           description: 'Indicates if the task is completed.'),
  //       'subTask': Schema(SchemaType.array,
  //           items: Schema(SchemaType.object, properties: {
  //             'title': Schema(SchemaType.string,
  //                 description: 'The title of the subtask.'),
  //             'description': Schema(SchemaType.string,
  //                 description: 'A detailed description of the subtask.'),
  //             'createdDate': Schema(SchemaType.string,
  //                 description:
  //                 'The date and time when the subtask was created.'),
  //             'deadline': Schema(SchemaType.string,
  //                 description: 'The deadline for the subtask.'),
  //             'completed': Schema(SchemaType.boolean,
  //                 description: 'Indicates if the subtask is completed.'),
  //             'taskId': Schema(SchemaType.string,
  //                 description:
  //                 'The ID of the task to which this subtask belongs.'),
  //           }, requiredProperties: [
  //             'title',
  //             'description',
  //             'createdDate',
  //             'deadline',
  //             'completed',
  //             'taskId'
  //           ]),
  //           description:
  //           'A list of subtasks associated with the task.(List of objects)'),
  //     }, requiredProperties: [
  //       'title',
  //       'description',
  //       'createdDate',
  //       'deadline',
  //       'completed',
  //       'subTask'
  //     ])));

  static final taskSchema = FunctionDeclaration(
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
