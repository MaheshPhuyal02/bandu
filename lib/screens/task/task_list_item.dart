import 'dart:math';

import 'package:bandu/models/task/task.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/ColorsConst.dart';
import '../../constants/Options.dart';
import '../../models/task/sub_task.dart';
import '../../services/db_manager.dart';

class TaskListItem extends StatefulWidget {
  late Task task;

  TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool showingSublist = false;

  final ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    showingSublist = !showingSublist;
                  });
                },
                icon: Icon(
                  showingSublist
                      ? Icons.keyboard_arrow_down_outlined
                      : Icons.keyboard_arrow_right_outlined,
                  color: ColorsConst.PRIMARY,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (String item) {},
                itemBuilder: (BuildContext context) {
                  return Options.taskOptions.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          showingSublist
              ? Container(
                  margin: EdgeInsets.only(left: 30.sp),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.task.subTask.length,
                    itemBuilder: (context, index) => _buildSubListItem(
                      task: widget.task.subTask[index],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  _buildSubListItem({required SubTask task}) {
    return Container(
        margin: EdgeInsets.only(top: 10.sp),
        padding: EdgeInsets.only(
          left: 10.sp,
          right: 5.sp,
          top: 10.sp,
          bottom: 10.sp,
        ),
        decoration: BoxDecoration(
          color: parseStatus(widget.task.status) == TaskStatus.DONE
              ? ColorsConst.GREEN_ACCENT
              : parseStatus(widget.task.status) == TaskStatus.IN_PROGRESS
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
                    widget.task.title,
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    widget.task.description,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 9.sp,
                      overflow: TextOverflow.ellipsis,
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
                    blastDirectionality: BlastDirectionality.explosive,
                    // don't specify a direction, blast randomly
                    shouldLoop: false,
                    // st// art again as soon as the animation is finished
                    colors: const [
                      ColorsConst.PRIMARY,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                    // manually specify the colors to be used
                    createParticlePath: drawStar, // define a custom shape/path.
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 7.sp, vertical: 4.sp),
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
                        updateStatus(
                            task.id,
                            'to_do');
                        break;
                      case 'In Progress':
                        updateStatus(
                            task.id,
                            'progress');
                        break;
                      case 'Done':
                        updateStatus(
                            task.id,
                            'done');
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

  TaskStatus parseStatus(String status) {
    switch (status) {
      case 'to_do':
        return TaskStatus.TO_DO;
      case 'progress':
        return TaskStatus.IN_PROGRESS;
      case 'done':
        return TaskStatus.DONE;
      default:
        return TaskStatus.TO_DO;
    }
  }

  Future<void> updateStatus(String subtaskId, String status) async {

    List<SubTask> list = List.from(widget.task.subTask);


    var subTask = list.where((element) {
      return element.id == subtaskId;
    }).first;
    subTask = subTask.copyWith(status: status);
    list.removeWhere((element) {
      return element.id == subtaskId;
    });

    list.add(subTask);

    widget.task = widget.task.copyWith(subTask: list);

    await DbManager.instance
        .updateTask(widget.task);
    setState(() {});
  }

}

enum TaskStatus {
  TO_DO,
  IN_PROGRESS,
  DONE,
}
