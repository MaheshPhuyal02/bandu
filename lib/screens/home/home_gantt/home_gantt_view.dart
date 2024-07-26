import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_gantt_provider.dart';

class Home_ganttPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Home_ganttProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Home_ganttProvider>();

    return Container();
  }
}

