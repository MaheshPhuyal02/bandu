import 'package:flutter/material.dart';

class ColorsConst {
  static const PRIMARY = Color(0xFF2071ED);
  static const GREEN_ACCENT = Color(0xFFC8FC9F);
  static const BLUE_ACCENT = Color(0xFF11FF00);
  static const PRIMARY_DARK = Color(0xFF1D63CE);
  static const PINK = Color(0xFFEF466F);
  static const YELLOW = Color(0xFFEFAB46);
  static const YELLOW_ACCENT = Color(0xFFFFE38F);


  static const BACKGROUND = Color(0xFF111214);
  static const WHITE = Color(0xFFFFFFFF);
  static const WHITE_ACCENT = Color(0xFFF1F1F1);
  static const BLACK = Color(0xFF000000);
  static const TRANS_BACK = Color(0xFF24262B);
  static const TEXT_SECONDARY = Color(0xFF2D2D2D);
  static const ICON_SECONDARY = Color(0xFF50535B);
  static const SECONDARY = Color(0x8BD9D9D9);
  static const WHITE_SHADOW = Color(0xFFE7E7E7);
  static const PRIMARY_BACK = Color(0xFF1A4D1F);
  static const SHADOW_GRAY  = Color(0xFF393C43);

  static parse(int i) {
    return Color(i);
  }

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

}