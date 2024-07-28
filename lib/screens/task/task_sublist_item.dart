import 'dart:math';

import 'package:bandu/constants/Options.dart';
import 'package:bandu/ext/sizes_ext.dart';
import 'package:bandu/screens/task/task_list_item.dart';
import 'package:confetti/confetti.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/ColorsConst.dart';

class TaskSublistItem extends StatefulWidget {
  TaskStatus status;

  TaskSublistItem({super.key, required this.status});

  @override
  State<TaskSublistItem> createState() => _TaskSublistItemState();
}

class _TaskSublistItemState extends State<TaskSublistItem> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    // TODO: implement initState
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.sp),
        padding: EdgeInsets.only(
          left: 10.sp,
          right: 5.sp,
          top: 10.sp,
          bottom: 10.sp,
        ),
        decoration: BoxDecoration(
          color: widget.status == TaskStatus.DONE
              ? ColorsConst.GREEN_ACCENT
              : widget.status == TaskStatus.IN_PROGRESS
                  ? ColorsConst.YELLOW_ACCENT
                  : ColorsConst.WHITE_ACCENT,
          borderRadius: BorderRadius.circular(9.sp),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/task_item.svg",
              width: 20.sp,
              height: 20.sp,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Work on design system',
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    'Task Description',
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            5.horizontalSpace,
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality
                        .explosive, // don't specify a direction, blast randomly
                    shouldLoop:
                    false, // st// art again as soon as the animation is finished
                    colors: const [
                      ColorsConst.PRIMARY,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ], // manually specify the colors to be used
                    createParticlePath: drawStar, // define a custom shape/path.
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 4.sp),
                    decoration: BoxDecoration(
                      color: ColorsConst.WHITE_SHADOW,
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.black,
                          size: 16.sp,
                        ),
                        2.horizontalSpace,
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.black,
                          size: 22.sp,
                        ),
                      ],
                    ),
                  ),
                  onSelected: (String item) {
                    switch (item) {
                      case 'To Do':
                        setState(() {
                          widget.status = TaskStatus.TO_DO;
                        });
                        break;
                      case 'In Progress':
                        setState(() {
                          widget.status = TaskStatus.IN_PROGRESS;
                        });
                        break;
                      case 'Done':
                        setState(() {
                          widget.status = TaskStatus.DONE;
                        });
                        print('Done');
                        _controllerCenter.play();
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return Options.taskStatusOptions.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            PopupMenuButton<String>(
              onSelected: (String item) {},
              itemBuilder: (BuildContext context) {
                return Options.subTaskOptions.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ));
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

}
