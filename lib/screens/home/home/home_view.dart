import 'package:bandu/constants/ColorsConst.dart';
import 'package:bandu/ext/sizes_ext.dart';
import 'package:bandu/ext/text_ext.dart';
import 'package:bandu/screens/home/home/home_view_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants/Options.dart';
import '../../../main.dart';
import '../../../models/task/sub_task.dart';
import '../../../routes/app_router.gr.dart';
import '../../task/task_list_item.dart';
import '../home_main_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        HomeViewProvider provider = HomeViewProvider();
        provider.init();
        return provider;
      },
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<HomeViewProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                20.verticalSpace,
                Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.verticalSpace,
                // Container(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.search,
                //         color: Colors.grey,
                //       ),
                //       10.horizontalSpace,
                //       Text(
                //         'Search anything.. ',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ],
                //   ),
                //   decoration: BoxDecoration(
                //     color: ColorsConst.WHITE_SHADOW,
                //     borderRadius: BorderRadius.circular(11.sp),
                //     border: Border.all(color: Colors.grey),
                //   ),
                // ),
                // 10.verticalSpace,
                Text(
                  'Recent Tasks',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ColorsConst.TEXT_SECONDARY,
                  ),
                ),
                10.verticalSpace,
                SizedBox(
                  child: Consumer<HomeViewProvider>(
                    builder: (context, provider, child) {
                      return provider.taskList.isEmpty
                          ? Center(
                              child: Text(
                                'No recent tasks.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.taskList.length,
                              itemBuilder: (context, index) {
                                print(
                                    "HomeTaskPage ::: TaskList length: ${provider.taskList.length}");
                                return TaskListItem(
                                  task: provider.taskList[index],
                                );
                              },
                            );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
/*
  _buildSubListItem(BuildContext context,
      {required SubTask task, required HomeViewProvider provider}) {
    print('buildSubListItem : ' + task.status);
    return InkWell(
      onTap: () {
        appRouter.push(
          Subtask_detailsRoute(
            subTask: task,
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
            color: TaskListItem.parseStatus(task.status) == TaskStatus.DONE
                ? ColorsConst.GREEN_ACCENT
                : TaskListItem.parseStatus(task.status) == TaskStatus.IN_PROGRESS
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
                            TaskListItem.parseStatus(task.status) == TaskStatus.DONE
                                ? Icons.check_circle
                                : TaskListItem.parseStatus(task.status) ==
                                TaskStatus.IN_PROGRESS
                                ? Icons.pending_outlined
                                : TaskListItem.parseStatus(task.status) ==
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
                          provider.updateSubStatus(task.id, task.taskId, 'to_do');
                          break;
                        case 'In Progress':
                          provider.updateSubStatus(task.id, task.taskId, 'progress');
                          break;
                        case 'Done':
                          provider.updateSubStatus(task.id, task.taskId, 'done');
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
                  provider.deleteSubTask(context, task.id, task.taskId);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 20.sp,
                ),
              ),
            ],
          )),
    ); */
}
