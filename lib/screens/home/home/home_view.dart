import 'package:bandu/constants/ColorsConst.dart';
import 'package:bandu/screens/task/task_sublist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../task/task_list_item.dart';
import 'home_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<HomeProvider>();
    final state = provider.state;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          20.verticalSpace,
          Text(
            'Hello',
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          10.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                10.horizontalSpace,
                Text(
                  'Search anything.. ',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: ColorsConst.WHITE_SHADOW,
              borderRadius: BorderRadius.circular(11.sp),
              border: Border.all(color: Colors.grey),
            ),
          ),

          10.verticalSpace,
          Text(
            'Recent Tasks',
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorsConst.TEXT_SECONDARY,
            ),
          ),

          10.verticalSpace,
          TaskListItem(),
          10.verticalSpace,

        ],
      ),
    );
  }
}
