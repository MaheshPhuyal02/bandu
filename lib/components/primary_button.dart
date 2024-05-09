
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/ColorsConst.dart';
import '../constants/SizesConst.dart';


class PrimaryButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final String iconPath;

  const PrimaryButton(
      {super.key, required this.text, required this.onPressed, required this.iconPath});
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            top: 9,
            bottom: 9
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizesConst.DEFAULT_RADIUS),
          color: ColorsConst.PRIMARY,
        ),
        child:

        TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.lightGreenAccent.withOpacity(0.8);
                }
                return Colors.transparent;
              },
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  color: ColorsConst.BLACK,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                iconPath,
                height: 24,
                width: 24,
              ),
            ],
          ),

        ),
      );
  }
}