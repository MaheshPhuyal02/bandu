import 'package:bandu/constants/prompts.dart';
import 'package:bandu/models/chat/message.dart';
import 'package:bandu/services/db_manager.dart';
import 'package:bandu/services/gemini_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';

import '../../models/chat/chat.dart';
import '../../models/prompt/prompt.dart';
import '../home/home_main_provider.dart';

class Ai_chatProvider extends ChangeNotifier {
  Prompt? selectedPrompt = null;

  bool loading = false;
  bool enableEditing = true;

  TextEditingController messageController = TextEditingController();


  List<Message> messageList = [];
  ScrollController scrollController = ScrollController();

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

  Future<void> init() async {
    messageList = [];
    messageList.addAll(await DbManager.instance.getChatHistory());
    notifyListeners();
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
    setEditing(false);
   _scrollToLast();
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
      response =
          await GeminiManager.instance.sendMessageWithCommand(message, cmd);
      GeminiManager.instance.addToHistory(message,  response);
    } else {
      response = await GeminiManager.instance.sendMessage(message);
      GeminiManager.instance.addToHistory(message,  response);
    }
    msg = msg.copyWith(response: response, loading: false);
    messageList[messageList.length - 1] = msg;

    DbManager.instance.addChatHistory(msg);

    _scrollToLast();
    loading = false;
    setEditing(true);

    notifyListeners();
  }

  _scrollToLast() {
    if(scrollController.hasClients){
      Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    }

  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void setEditing(bool value) {
    enableEditing = value;
    notifyListeners();
  }

}
