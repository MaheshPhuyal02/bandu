import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_provider.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SplashProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<SplashProvider>();


    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "TaskGen AI"
          ),
        ),
      ),
    );
  }
}

