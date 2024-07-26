import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ai_chat_provider.dart';

class Ai_chatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Ai_chatProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Ai_chatProvider>();

    return Container();
  }
}

