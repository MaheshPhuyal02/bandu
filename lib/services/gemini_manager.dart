import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

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
      tools: [
        Tool(functionDeclarations: [lightControlTool])
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

    final chat = _gemModel?.startChat();
    Future<GenerateContentResponse>? sendMessage =
        chat?.sendMessage(Content.text(message));
    String response = await sendMessage!.then((value) => value.text!);
    return response;
  }
}

enum GeminiStatus {
  loading,
  ready,
  error,
}
