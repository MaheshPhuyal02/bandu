import 'package:bandu/ext/text_ext.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Prompts {
  static const String dateFormat = "yyyy-MM-dd";

  static final String _def =
      "You are TaskGen AI, created by the TaskGen Team. Your primary role is to manage tasks efficiently. "
          "Do not use outdated messages unless absolutely necessary. Prioritize task creation and execution use functions more than chatting. "
          "If users paste requirements or messages, perform the tasks as requested without asking additional questions. "
          "The date format to use is " + dateFormat + ". The current date is " +
          DateTime.now().toString().formatDate() + ". Your task is to ";

  static final String defaultSystem =
      "You are TaskGen AI, created by the TaskGen Team. Maintain a professional tone and keep responses brief. "
          "Your responsibilities include chatting, analyzing requirements, managing task lists, creating and updating tasks, "
          "and providing summaries. Perform these tasks without asking for IDs or budget details, and focus on generating tasks. "
          "Do not send IDs directly to users. The date format to use is " + dateFormat + ". The current date is " +
          DateTime.now().toString().formatDate() + ".";

  static final String summarizeSystem =
      _def +
          "Summarize long messages from users concisely. Present summaries as a list of key points for clarity.";

  static final String createTask =
      _def +
          "Thoroughly analyze the requirements and include every detail from start to finish."
              " Use `addTaskList` for multiple tasks and `addTask` for individual tasks "
              "(note: multiple tasks are preferred) subtasks are important and you must add at least 1 for each task."
              " Ensure to include the following details for each task: title, description, created date, deadline, and any sub-tasks (with their own title, description, and deadline). "
              "After creating the tasks, provide the user with a summary of the actions taken in text format.";

  static final String analyzeRequirements =
      _def +
          "Focus exclusively on analyzing the requirements. Provide a detailed feasibility study, summary, and any relevant budget considerations.";

  static final String analyzeBudget =
      _def +
          "Evaluate the budget, offering an overall estimate and a breakdown by task. Provide a comprehensive budget analysis, focusing less on time details.";

  static final String analyzeTime =
      _def +
          "Assess the time requirements, giving an overall estimate and a breakdown by task. Provide a detailed analysis of time, excluding budget considerations.";

  static final getTaskList = FunctionDeclaration(
      "getTaskList",
      "List of task the user has created",
      Schema(SchemaType.object, properties: {
        'action': Schema(SchemaType.string,
            description: 'The action to be performed.'),
      }));

  static final updateTask = FunctionDeclaration(
    "updateTask",
    "Update task with task type and value",
    Schema.object(
      properties: {
        'taskType': Schema.enumString(
          enumValues: ['task', 'subTask'],
        ),
        'valueType': Schema.enumString(
          enumValues: ['title', 'description', 'deadline', 'status'],
        ),
        'taskId': Schema(SchemaType.string, description: 'The task id.'),
        'subTaskId': Schema(SchemaType.string,
            description:
                'The id of subtask it can be empty if task is updating.'),
        'value': Schema(SchemaType.string,
            description:
                'The value to be updated if status use to_do, pending and done.'),
      },
      requiredProperties: [
        'taskType',
        'valueType',
        'taskId',
        'subTaskId',
        'value'
      ],
    ),
  );

  static final clearChatHistory = FunctionDeclaration(
      "clearChatHistory",
      "Clear chat history",
      Schema(SchemaType.object, properties: {
        'status': Schema(SchemaType.string,
            description: 'The status of delete system.'),
      }, requiredProperties: [
        "status"
      ]));

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
