import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import 'task_details_provider.dart';

@RoutePage()
class TaskDetailsPage extends StatelessWidget {
  final String taskId;

  TaskDetailsPage({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskDetailsProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<TaskDetailsProvider>();

    return PaddingScaffold(child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          IconButton(
            onPressed: () {
              appRouter.maybePop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30.sp,
            ),
          ),
          30.verticalSpace,
          Text(
            "Task Details",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 23.sp,
            ),
          ),
          10.verticalSpace,
          Text(
            "Task Title",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 18.sp,
            ),
          ),
          10.verticalSpace,
          Text(
            "Task Description",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 18.sp,
            ),
          ),
          10.verticalSpace,
          Text(
            "Sub Task Title",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 18.sp,
            ),
          ),
          10.verticalSpace,
          Text(
            "Sub Task Description",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 18.sp,
            ),
          ),
          10.verticalSpace,
          Text(
            "Task Deadline",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 18.sp,
            ),
          ),
          10.verticalSpace,
          Text(
            "Sub Task Deadline",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    ));
  }
}

