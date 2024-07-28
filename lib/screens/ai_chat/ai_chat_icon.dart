import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AiChatIcon extends StatelessWidget {
  final bool animate;

  final Function() onEnd;
  const AiChatIcon({super.key, required this.animate, required this.onEnd});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: animate ? 1.2 : 1.0,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      onEnd: onEnd,
      child: Container(
        padding: EdgeInsets.all(0.sp),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                )
              ]),
          child: SvgPicture.asset(
            "assets/icons/logo.svg",
            width: 50.sp,
            height: 50.sp,
          )),
    );
  }
}
