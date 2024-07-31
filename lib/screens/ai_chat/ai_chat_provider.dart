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

  Future<void> sendMessage(BuildContext context) async {
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
    hideKeyboard(context);

    notifyListeners();

    String response;

    if (selectedPrompt.isNotEmpty || selectedPrompt != "/Chat") {
      String cmd = getSystemMessage(selectedPrompt);
      print("CMDDD  ::: " + cmd);
      response =
          await GeminiManager.instance.sendMessageWithCommand(message, cmd);
    } else {
      response = await GeminiManager.instance.sendMessage(message);
    }
    msg = msg.copyWith(response: response, loading: false);
    messageList[messageList.length - 1] = msg;

    loading = false;

    notifyListeners();
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }


  String getSystemMessage(String cmd) {

    switch (cmd) {
      case "/Chat":
        return Prompts.defaultSystem;
      case "/Summarize":
        return Prompts.summarizeSystem;
      case "/Create Task":
        return Prompts.createTask;
      case "/Analyze Requirements":
        return Prompts.analyzeRequirements;
      case "/Analyze Budget":
        return Prompts.analyzeBudget;
      case "/Analyze Time":
        return Prompts.analyzeTime;
      default:
        return Prompts.defaultSystem;
    }
  }
}
