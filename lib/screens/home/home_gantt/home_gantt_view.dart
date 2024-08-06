import 'dart:math';

import 'package:bandu/constants/ColorsConst.dart';
import 'package:bandu/screens/task/task_list_item.dart';
import 'package:dynamic_timeline_tile_flutter/dynamic_timeline_tile_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gantt_view/gantt_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'home_gantt_provider.dart';

class Home_ganttPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        Home_ganttProvider provider = Home_ganttProvider();
        provider.init();
        return provider;
      },
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Home_ganttProvider>();

    return Consumer<Home_ganttProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20.sp),
          child: dynamicTile(),
        );
      },
    );
  }

  dynamicTile() {
    return SingleChildScrollView(child: Consumer<Home_ganttProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            SizedBox(
              height: 12.h,
            ),
            MultiDynamicTimelineTileBuilder(
              itemCount: provider.dateList.length,
              itemBuilder: (context, index) {
                final date = provider.dateList;
                final eventsList = provider.getListFor(index);

                return MultiDynamicTimelineTile(
                  breakDate: true,
                  indicatorColor: ColorsConst.PRIMARY,
                  crossSpacing: 12.w,
                  mainSpacing: 16.h,
                  dateStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.4,
                      fontSize: 16.sp,
                  ),
                  starerDates: [
                    date[index],
                  ],
                  eventsList: [
                    eventsList.map((e) {
                      return EventCard(
                        cardColor: TaskListItem.parseStatus(e.status) ==
                                TaskStatus.DONE
                            ? ColorsConst.GREEN_ACCENT
                            : TaskListItem.parseStatus(e.status) ==
                                    TaskStatus.IN_PROGRESS
                                ? ColorsConst.YELLOW_ACCENT
                                : ColorsConst.WHITE_SHADOW,
                        child: CustomEventTile2(
                          taskTitle: provider.getTaskTitle(e.taskId),
                          icon: Icons.event,
                          title: e.title,
                          description: e.description,
                        ),
                      );
                    }).toList()
                  ],
                );
              },
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      },
    ));
  }
}

class CustomEventTile2 extends StatelessWidget {
  final String taskTitle;
  final String title;
  final String description;
  final Color? textColor;
  final Color? imageColor;
  final Color? iconColor;

  final IconData? icon;

  const CustomEventTile2(
      {super.key,
      required this.title,
      required this.description,
      this.textColor,
      this.icon,
      this.imageColor,
      this.iconColor,
      required this.taskTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          taskTitle,
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        5.verticalSpace,
        Container(
          height: 1.h,
          color: Colors.grey,
        ),
        5.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              icon ?? Icons.event,
              size: 17.sp,
              color: iconColor ?? Colors.black,
            )
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
