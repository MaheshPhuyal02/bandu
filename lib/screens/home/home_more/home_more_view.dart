import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_more_provider.dart';

class Home_morePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Home_moreProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Home_moreProvider>();

    return Container();
  }
}

