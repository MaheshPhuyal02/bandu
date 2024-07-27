import 'package:bandu/screens/task/task_sublist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/ColorsConst.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({super.key});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool showingSublist = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    showingSublist = !showingSublist;
                  });
                },
                icon: Icon(
                  showingSublist ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_right_outlined,
                  color: ColorsConst.PRIMARY,
                ),
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
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          showingSublist ?
          Container(
            margin: EdgeInsets.only(left: 30.sp),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) => TaskSublistItem(),
            ),
          ):Container(),
        ],
      ),
    );
  }
}
