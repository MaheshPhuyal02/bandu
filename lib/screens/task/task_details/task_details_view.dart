import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/ext/sizes_ext.dart';
import 'package:bandu/ext/text_ext.dart';
import 'package:bandu/models/task/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/ColorsConst.dart';
import '../../../constants/Options.dart';
import '../../../main.dart';
import '../task_list_item.dart';
import 'task_details_provider.dart';

@RoutePage()
class TaskDetailsPage extends StatelessWidget {
  final Task task;

  TaskDetailsPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return TaskDetailsProvider(task);
      },
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return PaddingScaffold(child: SingleChildScrollView(
      child: Consumer<TaskDetailsProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      appRouter.maybePop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30.sp,
                    ),
                  ),
                  1.flex,
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      provider.deleteTask(context, task.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              GestureDetector(
                onTap: () {
                  provider.setEditable("text", true);
                },
                child: TextField(
                  controller: provider.textController,
                  onSubmitted: (value) {
                    provider.setEditable("text", false);
                    provider.updateTitle(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Title",
                    enabled: provider.isTextEditable,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
              ),
              10.verticalSpace,
              PopupMenuButton<String>(
                position: PopupMenuPosition.under,
                padding: EdgeInsets.zero,
                icon: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.sp, vertical: 8.sp),
                  decoration: BoxDecoration(
                    color: TaskListItem.parseStatusColor(task.status),
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
                        size: 22.sp,
                      ),
                      5.horizontalSpace,
                      Expanded(
                        child: Text(
                          TaskListItem.parseStatusString(task.status),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      2.horizontalSpace,
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.black,
                        size: 26.sp,
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
              10.verticalSpace,
              Text("Description",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      )),
              GestureDetector(
                onTap: () {
                  provider.setEditable("description", true);
                },
                child: TextField(
                  maxLines: 5,
                  minLines: 2,
                  controller: provider.descriptionController,
                  onTapOutside: (ev) {
                    provider.setEditable("description", false);
                    provider.updateDescription();
                  },
                  onSubmitted: (value) {
                    provider.setEditable("description", false);
                    provider.updateDescription();
                  },
                  decoration: InputDecoration(
                    hintText: "Description",
                    enabled: provider.isDescriptionEditable,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 13.sp,
                      ),
                ),
              ),
              10.verticalSpace,
              Text("Started Date",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      )),
              Text(
                task.createdDate.toString().formatDate(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 13.sp,
                    ),
              ),
              10.verticalSpace,
              Text("Deadline",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      )),
              Row(
                children: [
                  Text(
                    task.deadline.toString().formatDate(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 13.sp,
                        ),
                  ),
                  4.horizontalSpace,
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      provider.showDeadlinePicker(context);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Text(
                "Sub tasks",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
              ),
              10.verticalSpace,
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.task?.subTask.length,
                  itemBuilder: (context, index) =>
                      TaskListItem.buildSubListItem(context,
                          task: provider.task!.subTask[index],
                          provider: provider),
                ),
              )
            ],
          );
        },
      ),
    ));
  }
}
