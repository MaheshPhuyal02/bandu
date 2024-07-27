import 'package:auto_route/annotations.dart';
import 'package:bandu/screens/ai_chat/ai_chat_icon.dart';
import 'package:bandu/screens/home/home/home_view.dart';
import 'package:bandu/screens/home/home_gantt/home_gantt_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'home_main_provider.dart';
import 'home_task/home_task_view.dart';

@RoutePage()
class HomeMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: provider.selectedIndex,
            iconSize: 20.sp,
            selectedIconTheme: IconThemeData(
                size: 20.sp, color: Theme.of(context).primaryColor),
            onTap: (index) {
              provider.setSelectedIndex(index);
            },
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  width: 20.sp,
                  height: 20.sp,
                  color: provider.selectedIndex == 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/task.svg",
                  width: 25.sp,
                  height: 25.sp,
                  color: provider.selectedIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/timeline.svg",
                  width: 20.sp,
                  height: 20.sp,
                  color: provider.selectedIndex == 2
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                label: 'Timeline',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/more.svg",
                  width: 20.sp,
                  height: 20.sp,
                  color: provider.selectedIndex == 3
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                label: 'More',
              ),
            ],
          ),
          body: SafeArea(
            child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                return Stack(
                  children: [
                    getBody(provider.selectedIndex),
                    Positioned(
                      left: provider.x1,
                      top: provider.y1,
                      child: GestureDetector(
                        onTap: () {
                          provider.toggleChatView();
                        },
                          onPanDown: (d) {
                            provider.x1Prev = provider.x1;
                            provider.y1Prev = provider.y1;
                          },
                          onPanUpdate: (details) {

                            provider.setIconCoordinates(
                                provider.x1Prev + details.localPosition.dx,
                                provider.y1Prev + details.localPosition.dy,
                                provider.x2,
                                provider.y2);
                          },
                          child: AiChatIcon()),
                    ),

                    getChatView(provider.showChat),

                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  getChatView(bool show) {

    if(show) {
      return Container(
        margin: EdgeInsets.only(top: 50.h,),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text('Chat'),
        ),
      );
    }

    return Container();
  }

  getBody(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return HomePage();
      case 1:
        return HomeTaskPage();
      case 2:
        return Home_ganttPage();
      case 3:
        return Container(
          child: Center(
            child: Text('More'),
          ),
        );
    }
  }

  showMore() {
    return Container(
      child: Center(
        child: Text('More'),
      ),
    );
  }

  showChatView(int selected) {
    return Container(
      child: Center(
        child: Text(
          'Chat' + selected.toString(),
        ),
      ),
    );
  }
}
