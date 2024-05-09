
import 'package:flutter/material.dart';

class BasicTitle2 extends StatelessWidget {
  final String title;

  const BasicTitle2(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      )
    );
  }
}