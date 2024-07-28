import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gantt_view/gantt_view.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
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

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20.sp),
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.3,
        indicatorStyle: IndicatorStyle(
          width: 20.sp,
          height: 20.sp,
          indicator: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
        endChild: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
          ),
          color: Colors.lightGreenAccent,
        ),

        startChild: Container(
          color: Colors.amberAccent,
        ),
      ),
    );
  }
}
