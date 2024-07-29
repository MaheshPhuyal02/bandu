import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'select_project_provider.dart';

@RoutePage()
class SelectProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SelectProjectProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<SelectProjectProvider>();

    return PaddingScaffold(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        20.verticalSpace,
        Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 30.sp,
        ),
        30.verticalSpace,
        Text(
          "Create Project",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 23.sp,
              ),
        ),
        10.verticalSpace,
        TextFormField(

          onChanged: (value) {

          },

          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your email";
            }


            return null;
          },
          decoration: InputDecoration(
            hintText: "Enter project title.",
          ),
        ),
      ],
    ));
  }
}
