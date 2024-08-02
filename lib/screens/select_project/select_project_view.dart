import 'package:auto_route/annotations.dart';
import 'package:bandu/components/padding_scaffold.dart';
import 'package:bandu/components/primary_button.dart';
import 'package:bandu/constants/ColorsConst.dart';
import 'package:bandu/constants/Options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'select_project_provider.dart';

@RoutePage()
class SelectProjectPage extends StatelessWidget {
  final bool canGoBack;

  const SelectProjectPage({super.key, this.canGoBack = true});

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

    return PaddingScaffold(child: Consumer<SelectProjectProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                    10.verticalSpace,
                    Text(
                      "Select Project Type",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                      ),
                    ),
                    10.verticalSpace,
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorsConst.WHITE_ACCENT,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                      child: PopupMenuButton<String>(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                provider.selectedProjectType,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                              size: 25.sp,
                            ),
                          ],
                        ),
                        onSelected: (String item) {
                          provider.setSelectedType(item);
                        },
                        itemBuilder: (BuildContext context) {
                          return Options.ProjectType.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              Container(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 100.w,
                  child: PrimaryButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        provider.addNewProject(context);
                      }
                    },
                    text: "Create",
                  ),
                ),
              ),
              10.verticalSpace,
              provider.projects.isNotEmpty
                  ? Row(
                      children: [
                        Expanded(
                            child: Container(
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
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          height: 1.h,
                          color: Colors.grey.withOpacity(0.9),
                        )),
                      ],
                    )
                  : Container(),
              10.verticalSpace,
              provider.projects.isNotEmpty
                  ? Text(
                      "Select Project",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 23.sp,
                              ),
                    )
                  : Container(),
              10.verticalSpace,
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.projects.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      provider.selectProject(provider.projects[index].id);
                    },
                    title: Text(provider.projects[index].title),
                    subtitle: Text("Last updated on " +
                        provider.projects[index].lastUpdated.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        provider.deleteProject(context, index);
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
        );
      },
    ));
  }
}
