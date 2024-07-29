import 'package:bandu/constants/prompts.dart';
import 'package:bandu/models/chat/message.dart';
import 'package:bandu/services/gemini_manager.dart';
import 'package:flutter/material.dart';

import '../../models/chat/chat.dart';

class Ai_chatProvider extends ChangeNotifier {
  String selectedPrompt = '';

  int selectedIndex = 0;

  bool loading = false;

  TextEditingController messageController = TextEditingController();

  List<Message> messageList = [];

  void setSelectedPrompt(String prompt) {
    selectedPrompt = prompt;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> sendMessage() async {
    String message = messageController.text;
    if (message.isEmpty) return;

    if (loading) return;
    loading = true;

    Message msg = Message(
        id: "12",
        request: message,
        response: null,
        loading: true,
        actionType: ActionType.chat);

    messageController.clear();
    messageList.add(msg);

    notifyListeners();

    String response;

    if (selectedPrompt.isNotEmpty || selectedPrompt != "/Chat") {
      if (selectedPrompt == "/Summarize") {
        String cmd = Prompts.createTask;
        response =
            await GeminiManager.instance.sendMessageWithCommand(message, cmd);
      } else {
        response = await GeminiManager.instance.sendMessage(
          message,
        );
      }
    } else {
      response = await GeminiManager.instance.sendMessage(message);
    }

    msg = msg.copyWith(response: response, loading: false);

    messageList[messageList.length - 1] = msg;

    loading = false;

    notifyListeners();
  }
}
