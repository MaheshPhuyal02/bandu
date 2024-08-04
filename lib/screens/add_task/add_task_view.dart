import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter project title.";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter task title.",
                          ),
                        ),
                        10.verticalSpace,TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter project title.";
                            }

                            return null;
                          },
                          maxLines: 6,
                          minLines: 3,
                          decoration: const InputDecoration(
                            hintText: "Enter task description (Optional).",

                          ),
                        ),
                        10.verticalSpace,
                      ]),
                ),
                PrimaryButton(
                    text: "Add Task",
                    onPressed: () {
                      // Add task logic here
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
