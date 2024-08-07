import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'subtask_details_provider.dart';

class Subtask_detailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Subtask_detailsProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Subtask_detailsProvider>();

    return Container();
  }
}

