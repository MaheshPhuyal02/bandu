import 'package:bandu/ext/sizes_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../task/task_list_item.dart';
import 'home_task_provider.dart';

class HomeTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        Home_todoProvider provider = Home_todoProvider();
        provider.init();
        return provider;
      },
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<Home_todoProvider>(
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
                    ListView.builder(
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
                onPressed: () {},
              ),
            )
          ],
        );
      },
    );
  }
}
