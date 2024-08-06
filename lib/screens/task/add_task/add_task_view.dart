import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/components/primary_button.dart';
import 'package:bandu/constants/ColorsConst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import 'add_task_provider.dart';

@RoutePage()
class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddTaskProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  final _key = GlobalKey<FormState>();

  Widget _buildPage(BuildContext context) {
    context.read<AddTaskProvider>();

    return PaddingScaffold(
      child: SingleChildScrollView(
        child: Consumer<AddTaskProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  "Add Task",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 23.sp,
                      ),
                ),
                10.verticalSpace,
                Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          provider.taskTitle = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter task title.";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter task title.",
                        ),
                      ),
                      10.verticalSpace,
                      TextFormField(
                        onChanged: (value) {
                          provider.taskDescription = value;
                        },
                        maxLines: 6,
                        minLines: 3,
                        decoration: const InputDecoration(
                          hintText: "Enter task description (Optional).",
                        ),
                      ),
                      10.verticalSpace,
                      InkWell(
                        onTap: () {
                          provider.selectDate(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            color: ColorsConst.WHITE_SHADOW,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            "Select Deadline" +
                                " : " +
                                provider.selectedDate.toString().substring(0, 10),
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),

                        ),
                      ),
                      10.verticalSpace,
                      Text("Sub task"),
                      10.verticalSpace,
                      TextFormField(
                        onChanged: (value) {
                          provider.subTitle = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter sub task title.";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter sub task title.",
                        ),
                      ),
                      10.verticalSpace,
                      TextFormField(
                        onChanged: (value) {
                          provider.subDescription = value;
                        },
                        maxLines: 6,
                        minLines: 3,
                        decoration: const InputDecoration(
                          hintText: "Enter subtask description (Optional).",
                        ),
                      ),
                      10.verticalSpace,
                      InkWell(
                        onTap: () {
                          provider.selectDate(context, subTask: true);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            color: ColorsConst.WHITE_SHADOW,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Text(
                            "Select Deadline" +
                                " : " +
                                provider.selectedSubDate.toString().substring(0, 10),
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),

                10.verticalSpace,
                PrimaryButton(
                    text: "Add Task",
                    onPressed: () {
                      if(_key.currentState!.validate()){
                        provider.submit(context);
                      }


                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
