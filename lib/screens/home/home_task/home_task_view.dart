import 'package:bandu/ext/sizes_ext.dart';
import 'package:bandu/main.dart';
import 'package:bandu/routes/app_router.gr.dart';
import 'package:bandu/screens/home/home_gantt/home_gantt_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../task/task_list_item.dart';
import 'home_task_provider.dart';

class HomeTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Consumer<Home_ganttProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      30.verticalSpace,
                      Text(
                        'Your Tasks',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      10.verticalSpace,
                      provider.taskList.isEmpty
                          ? SizedBox(
                              height: 100.pW,
                              child: Center(
                                child: Text(
                                  'No tasks available, Click on + or ask TaskGen AI to add task.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.taskList.length,
                              itemBuilder: (context, index) {
                                print("HomeTaskPage ::: TaskList length: " +
                                    provider.taskList.length.toString());
                                return TaskListItem(
                                  task: provider.taskList[index],
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20.sp,
                right: 20.sp,
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    appRouter.push(AddTaskRoute());
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
