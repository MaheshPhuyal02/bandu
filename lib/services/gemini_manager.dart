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
    final apiKey = Platform.environment['API_KEY'];
    if (apiKey == null) {
      status = GeminiStatus.error;
      throw Exception('API_KEY is not set');
    }

    _gemModel = GenerativeModel(model: _model, apiKey: apiKey);
    status = GeminiStatus.ready;
  }

  _sendMessage({
    required String system,
    required String message,
  }) {}






}


enum GeminiStatus {
  loading,
  ready,
  error,
}
