import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'select_project_provider.dart';

@RoutePage()
class SelectProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        var selectProjectProvider = SelectProjectProvider();
        selectProjectProvider.init();
        return selectProjectProvider;
      },
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<SelectProjectProvider>();

    final _formKey = GlobalKey<FormState>();

    return PaddingScaffold(
        child: SingleChildScrollView(
          child: Column(
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
            "Create Project",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 23.sp,
                ),
          ),
          10.verticalSpace,
          Form(
            key: _formKey,
            child:
              TextFormField(
                controller: provider.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter project title.";
                  }


                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter project title.",
                ),
              ),

          ),

          10.verticalSpace,
          Container(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 100.w,
              child: PrimaryButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    provider.addNewProject(context);
                  }
                },
                text: "Create",
              ),
            ),
          ),

          10.verticalSpace,
          provider.projects.isNotEmpty?
          Row(
            children: [
              Expanded(child: Container(
                width: double.infinity,
                height: 1.h,
                color: Colors.grey.withOpacity(0.9),
              )),
              10.horizontalSpace,
              Text(
                "Or",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              10.horizontalSpace,
              Expanded(child: Container(
                width: double.infinity,
                height: 1.h,
                color: Colors.grey.withOpacity(0.9),
              )),
            ],
          ):Container(),

          10.verticalSpace,
          provider.projects.isNotEmpty?
          Text(
            "Select Project",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 23.sp,
            ),
          ):Container(),

          10.verticalSpace,
          ListView.builder(
            shrinkWrap: true,
            itemCount: provider.projects.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  // appRouter.push(SelectProjectRoute());
                },
                title: Text("Example project"),
                subtitle: Text("Last updated on 12/12/2021"),
                trailing: IconButton(
                  onPressed: () {
                    // appRouter.push(SelectProjectRoute());
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/delete.svg",
                    width: 20.w,
                    height: 20.w,
                  ),
                ),
              );
            },
          ),

                ],
              ),
        ));
  }
}
