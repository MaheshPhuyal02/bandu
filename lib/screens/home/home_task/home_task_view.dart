import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_task_provider.dart';

class Home_todoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Home_todoProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Home_todoProvider>();

    return Container();
  }
}

