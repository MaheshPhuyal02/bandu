import 'dart:math';

import 'package:bandu/ext/text_ext.dart';
import 'package:bandu/models/task/task.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants/ColorsConst.dart';
import '../../constants/Options.dart';
import '../../models/task/sub_task.dart';
import '../../services/db_manager.dart';
import '../home/home_task/home_task_provider.dart';

class TaskListItem extends StatelessWidget {
  late Task task;

  TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        TaskListProvider provider = TaskListProvider();
        provider.init(task);
        return provider;
      },
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<TaskListProvider>(
      builder: (context, provider, child) {
        return Container(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      provider.toggleSublist();
                    },
                    child: Icon(
                      provider.showingSublist
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_right_outlined,
                      color: ColorsConst.PRIMARY,
                      size: 25.sp,
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          provider.task.title,
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
              provider.showingSublist
                  ? Container(
                      margin: EdgeInsets.only(left: 30.sp),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.task.subTask.length,
                        itemBuilder: (context, index) => _buildSubListItem(
                            task: provider.task.subTask[index],
                            provider: provider),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  _buildSubListItem({required SubTask task, required provider}) {
    print('buildSubListItem : ' + task.status);
    return Container(
        margin: EdgeInsets.only(top: 10.sp),
        padding: EdgeInsets.only(
          left: 10.sp,
          right: 5.sp,
          top: 10.sp,
          bottom: 10.sp,
        ),
        decoration: BoxDecoration(
          color: parseStatus(task.status) == TaskStatus.DONE
              ? ColorsConst.GREEN_ACCENT
              : parseStatus(task.status) == TaskStatus.IN_PROGRESS
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
                    task.title,
                    style: TextStyle(
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    task.deadline.toString().formatDate(),
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 11.sp,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black38,
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
                    confettiController: provider.controllerCenter,
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
                          parseStatus(task.status) == TaskStatus.DONE
                              ? Icons.check_circle
                              : parseStatus(task.status) ==
                                      TaskStatus.IN_PROGRESS
                                  ? Icons.pending_outlined
                                  : parseStatus(task.status) == TaskStatus.DONE
                                      ? Icons.check_circle_outline
                                      : Icons.access_time,
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
                        provider.updateStatus(task.id, 'to_do');
                        break;
                      case 'In Progress':
                        provider.updateStatus(task.id, 'progress');
                        break;
                      case 'Done':
                        provider.updateStatus(task.id, 'done');
                        print('Done');

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

  static TaskStatus parseStatus(String status) {
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
}

class TaskListProvider extends ChangeNotifier {
  bool showingSublist = false;
  late Task task;
  final ConfettiController controllerCenter =
      ConfettiController(duration: const Duration(seconds: 1));

  void init(task) {
    this.task = task;
  }

  void toggleSublist() {
    showingSublist = !showingSublist;
    notifyListeners();
  }

  Future<void> updateStatus(String subtaskId, String status) async {
    task.subTask.forEach((element) {
      if (element.id == subtaskId) {
        if (element.status != status) {
          if (status == 'done') {
            controllerCenter.play();
          }
          print('Status: ' + element.status);
          element.status = status;
          notifyListeners();
        }
      }
    });
    await DbManager.instance.updateTask(task);
  }
}

enum TaskStatus {
  TO_DO,
  IN_PROGRESS,
  DONE,
}
