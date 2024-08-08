import 'package:bandu/models/chat/message.dart';

class Tools{

  static ActionType parseActionType(String s){
    switch(s){
      case "chat":
        return ActionType.chat;
      case "analyzeRequirements":
        return ActionType.analyzeRequirements;
      case "createTask":
        return ActionType.createTask;
      case "analyzeBudget":
        return ActionType.analyzeBudget;
      case "analyzeTime":
        return ActionType.analyzeTime;
      case "summarize":
        return ActionType.summarize;
      default:
        return ActionType.chat;
    }
  }

}