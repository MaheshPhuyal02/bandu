import 'package:bandu/constants/BUTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/ColorsConst.dart';

class UiMessages {
  static void showError(String msg) {}

  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: SpinKitFadingCircle(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: ColorsConst.WHITE,
                borderRadius: BorderRadius.circular(100),
              ),
            );
          },
        ),
      ),
    );
  }
}
