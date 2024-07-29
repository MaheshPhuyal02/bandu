import 'package:bandu/constants/BUTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/ColorsConst.dart';

class UiMessages {
  static void showError(BuildContext context, String msg) {
    showAdaptiveDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    });
  }

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

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showMessage(
      BuildContext context,
      String message ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
