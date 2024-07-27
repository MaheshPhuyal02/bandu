import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/ColorsConst.dart';

class TaskSublistItem extends StatelessWidget {
  const TaskSublistItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.sp),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9.sp),
          border: Border.all(color: ColorsConst.PRIMARY),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/task_item.svg",
              width: 20.sp,
              height: 20.sp,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Work on design system',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Task Description',
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ],
        ));
  }
}
