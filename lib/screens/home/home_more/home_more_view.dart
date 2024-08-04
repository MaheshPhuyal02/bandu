import 'package:bandu/ext/sizes_ext.dart';
import 'package:bandu/main.dart';
import 'package:bandu/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'home_more_provider.dart';

class Home_morePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        Home_moreProvider provider = Home_moreProvider();
        provider.init();
        return provider;
      },
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Home_moreProvider>();

    return Container(
      height: 47.pH,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              10.horizontalSpace,
              Expanded(
                child: Text(
                  provider.currentProjectName,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              10.horizontalSpace,

              IconButton(
                onPressed: () {
                  appRouter.push(SelectProjectRoute());
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey,
                  size: 40.sp,
                ),
              ),

            ],
          ),
          10.verticalSpace,
          Container(
            width: double.infinity,
            height: 1.h,
            color: Colors.grey.withOpacity(0.5),
          ),

          10.verticalSpace,

          Row(
            children: [
              Expanded(child: _buildMenuItem("Profile", "assets/icons/person.svg", (){}, context)),
              Expanded(child: _buildMenuItem("Notes", "assets/icons/notes.svg", (){}, context)),
              Expanded(child: _buildMenuItem("Profile", "assets/icons/notification.svg", (){}, context)),
            ],
          ),
          20.verticalSpace,

          Row(
            children: [
              Expanded(child: _buildMenuItem("Setting", "assets/icons/setting.svg", (){}, context)),
              Expanded(child: _buildMenuItem("Logout", "assets/icons/logout.svg", (){
                provider.logout(context);
              }, context)),
            Expanded(child: Container()),
            ],
          ),

        ],
      ),
    );
  }


  _buildMenuItem(String title, String iconPath, Function() onTap, BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 25.sp,
              height: 25.sp,
            ),
            10.horizontalSpace,
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
