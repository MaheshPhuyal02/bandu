import 'dart:math';

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
      create: (BuildContext context) => Home_ganttProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<Home_ganttProvider>();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20.sp),
      child: dynamicTile(),
    );
  }

  dynamicTile() {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 12.h,
        ),
        DynamicTimelineTileBuilder(
          // itemCount: myEvents.keys.toList().length,

          itemBuilder: (context, index) {
            return DynamicTimelineTile(
              indicatorRadius: 5.sp,

              indicatorWidth: 3.w,
              // break dates helps to break the date into day and month format

              // Split complete date into two parts

              breakDate: true,
              // By default it is true

              // make breakDate: false, if you doesnt wants to break the line

              // indicator colors

              indicatorColor: Colors.purple.withOpacity(0.3),
              // Define the color of line middle of dates and events tile

              // cross spacing
              crossSpacing: 12.w,
              // Cross spacing create the space between the dates, indicator and content tile

              // Main spacing
              mainSpacing: 16.h,
              // Main spacing create the vertical spacing between two content and dates tile

              // Textstyle for starer dates

              dateStyle: GoogleFonts.mulish(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.4,
                  fontSize: 22.sp),

              // make the dates

              starerChild: [
                Icon(Icons.home),
              ],

              // starerDates: [
              //   eventData[index]["date"]!,
              // ],
              events: [
                EventCard(
                  child: customEventTile(
                      context: context,
                      title: eventData[index]["title"]!,
                      description: eventData[index]["description"]!),
                )
              ],
            );
          },
          itemCount: eventData.length,
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    ));
  }

  final List<Map<String, String>> eventData = [
    {
      "title": "Title",
      "description": "This is a content description for 12 jan",
      "date": "2 Jan",
    },
    {
      "title": "Title",
      "description": "This is a content description for 13 jan",
      "date": "13 Jan",
    },
    {
      "title": "Title",
      "description": "This is a content description for 14 jan",
      "date": "14 Jan",
    },
    {
      "title": "Title",
      "description": "This is a content description for 15 jan",
      "date": "15 Jan",
    },
  ];

  customEventTile(
      {required BuildContext context,
      required String title,
      required String description,
      Color? textColor,
      Color? imageColor,
      IconData? icon,
      Color? iconColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.mulish(
                color: textColor ?? Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
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
          height: 12.h,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 80.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: imageColor ?? Colors.blue),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          description,
          style: GoogleFonts.mulish(
            color: textColor ?? Colors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
