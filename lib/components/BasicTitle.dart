
import 'package:flutter/material.dart';

class BasicTitle extends StatelessWidget {
  final String title;

  const BasicTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      )
    );
  }
}