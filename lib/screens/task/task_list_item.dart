import 'dart:math';

import 'package:bandu/ext/text_ext.dart';
import 'package:bandu/main.dart';
import 'package:bandu/models/task/task.dart';
import 'package:bandu/routes/app_router.gr.dart';
import 'package:bandu/screens/task/task_details/task_details_provider.dart';
import 'package:bandu/services/ui_messages.dart';
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
        TaskDetailsProvider provider = TaskDetailsProvider();
        provider.init(task);
        return provider;
      },
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<TaskDetailsProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () {
            appRouter.push(
              TaskDetailsRoute(
                task: provider.task!,
              ),
            );
          },
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      provider.toggleSublist();
                    },
                    child: Icon(
                      provider.showSublist
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
                          provider.task!.title,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        5.verticalSpace,
                        Text(
                          "Deadline : ${provider.task!.deadline.toString().formatDate()}",
                          style: TextStyle(
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  PopupMenuButton<String>(
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 7.sp, vertical: 4.sp),
                      decoration: BoxDecoration(
                        color: parseStatusColor(provider.task!.status),
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
                                : parseStatus(task.status) ==
                                TaskStatus.DONE
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
                          provider.updateStatus('to_do');
                          break;
                        case 'In Progress':
                          provider.updateStatus('progress');
                          break;
                        case 'Done':
                          provider.updateStatus('done');
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

                  5.horizontalSpace,
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 20.sp,
                    constraints: BoxConstraints(
                      maxHeight: 20.sp,
                      maxWidth: 20.sp,
                    ),
                    onPressed: () {
                      provider.deleteTask(
                        context,
                        provider.task!.id,
                        close: false,
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
              provider.showSublist
                  ? Container(
                      margin: EdgeInsets.only(left: 30.sp),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.task?.subTask.length,
                        itemBuilder: (context, index) => buildSubListItem(
                            context,
                            task: provider.task!.subTask[index],
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

  static buildSubListItem(BuildContext context,
      {required SubTask task, required TaskDetailsProvider provider}) {
    print('buildSubListItem : ' + task.status);
    return InkWell(
      onTap: () {
        appRouter.push(
          Subtask_detailsRoute(
            subTask: task,
            task: provider.task!,
          ),
        );
      },
      child: Container(
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
                      createParticlePath:
                          drawStar, // define a custom shape/path.
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 7.sp, vertical: 4.sp),
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
                                    : parseStatus(task.status) ==
                                            TaskStatus.DONE
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
                          provider.updateSubStatus(task.id, 'to_do');
                          break;
                        case 'In Progress':
                          provider.updateSubStatus(task.id, 'progress');
                          break;
                        case 'Done':
                          provider.updateSubStatus(task.id, 'done');
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
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 20.sp,
                constraints: BoxConstraints(
                  maxHeight: 20.sp,
                  maxWidth: 20.sp,
                ),
                onPressed: () {
                  provider.deleteSubTask(context, task.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 20.sp,
                ),
              ),
            ],
          )),
    );
  }

  static Path drawStar(Size size) {
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

  static String parseStatusString(String status) {
    switch (status) {
      case 'to_do':
        return "Todo";
      case 'progress':
        return "Pending";
      case 'done':
        return "Done";
      default:
        return "Todo";
    }
  }

  static parseStatusColor(String status) {
    switch (status) {
      case 'to_do':
        return ColorsConst.WHITE_ACCENT;
      case 'progress':
        return ColorsConst.YELLOW_ACCENT;
      case 'done':
        return ColorsConst.GREEN_ACCENT;
      default:
        return ColorsConst.YELLOW_ACCENT;
    }
  }
}

enum TaskStatus {
  TO_DO,
  IN_PROGRESS,
  DONE,
}
