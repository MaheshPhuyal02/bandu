import 'package:bandu/ext/sizes_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'home_more_provider.dart';

class Home_morePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Home_moreProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Home_moreProvider>();

    return Container(
      height: 57.pH,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          10.verticalSpace,
          Row(
            children: [
              10.horizontalSpace,
              Expanded(
                child: Text(
                  "Example Generator",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              10.horizontalSpace,

              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey,
                  size: 40.sp,
                ),
              ),

            ],
          ),
          20.verticalSpace,
          Container(
            width: double.infinity,
            height: 1.h,
            color: Colors.grey.withOpacity(0.5),
          ),

          20.verticalSpace,

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
              Expanded(child: _buildMenuItem("Logout", "assets/icons/logout.svg", (){}, context)),
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
              width: 30.sp,
              height: 30.sp,
            ),
            10.horizontalSpace,
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
