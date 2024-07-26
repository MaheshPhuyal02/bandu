import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaddingScaffold extends StatelessWidget {
  final Widget child;
  const PaddingScaffold({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(19.sp),
          child: child,
        ),
      ),
    );
  }
}
