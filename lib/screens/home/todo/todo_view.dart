import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TodoProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<TodoProvider>();

    return Container();
  }
}

