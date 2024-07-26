import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizesExt on num {
  double get pW => ScreenUtil.defaultSize.width * this / 100;

  double get pH => ScreenUtil.defaultSize.height * this / 100;

  Expanded get flex => Expanded(
        child: Container(),
      );
}
