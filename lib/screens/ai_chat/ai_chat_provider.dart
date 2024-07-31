import 'package:bandu/constants/prompts.dart';
import 'package:bandu/models/chat/message.dart';
import 'package:bandu/services/gemini_manager.dart';
import 'package:flutter/material.dart';

import '../../models/chat/chat.dart';
import '../../models/prompt/prompt.dart';

class Ai_chatProvider extends ChangeNotifier {
  Prompt? selectedPrompt = null;

  bool loading = false;

  TextEditingController messageController = TextEditingController();

  List<Message> messageList = [];

  List<Prompt> prompts = [
    Prompt(name: "Chat", prompt: Prompts.defaultSystem, selected: true),
    Prompt(
        name: "Analyze Requirements",
        prompt: Prompts.analyzeRequirements,
        selected: false),
    Prompt(name: "Create Task", prompt: Prompts.createTask, selected: false),
    Prompt(
        name: "Analyze Budget", prompt: Prompts.analyzeBudget, selected: false),
    Prompt(name: "Analyze Time", prompt: Prompts.analyzeTime, selected: false),
    Prompt(
        name: "Summarize System",
        prompt: Prompts.summarizeSystem,
        selected: false),
  ];

  Ai_chatProvider() {
    selectedPrompt = prompts[0];
  }

  void setSelectedPrompt(Prompt prompt) {
    print("PROMPT ::: " + prompt.toJson().toString());
    selectedPrompt = prompt;
    notifyListeners();
  }

  Future<void> sendMessage(BuildContext context) async {
    String message = messageController.text;
    if (message.isEmpty) return;

    if (loading) return;
    loading = true;

    Message msg = Message(
        id: DateTime.now().toString(),
        request: message,
        response: null,
        loading: true,
        actionType: ActionType.chat);

    messageController.clear();
    messageList.add(msg);
    hideKeyboard(context);

    notifyListeners();

    String response;

    if (selectedPrompt != null || selectedPrompt?.name != "Chat") {
      String cmd = selectedPrompt!.prompt;
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
}
