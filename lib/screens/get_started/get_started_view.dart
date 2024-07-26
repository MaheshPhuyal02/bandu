import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'get_started_provider.dart';

class Get_startedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Get_startedProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Get_startedProvider>();

    return Container();
  }
}

