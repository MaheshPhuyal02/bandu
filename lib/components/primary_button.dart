import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/ColorsConst.dart';
import '../constants/SizesConst.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(

      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizesConst.DEFAULT_RADIUS),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {

            if(states.contains(WidgetState.focused) || states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)){
              return ColorsConst.PRIMARY.withOpacity(0.899);
            }

            return ColorsConst.PRIMARY;
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.focused)) {
              return Colors.blueAccent.withOpacity(0.6);
            }
            return Colors.transparent;
          },
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 7.h),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            color: ColorsConst.WHITE,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
