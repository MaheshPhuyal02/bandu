import 'package:flutter/material.dart';

class ColorsConst {
  static const PRIMARY = Color(0xFF2071ED);
  static const PRIMARY_DARK = Color(0xFF1D63CE);
  static const PINK = Color(0xFFEF466F);
  static const YELLOW = Color(0xFFEFAB46);
  static const BACKGROUND = Color(0xFF111214);
  static const WHITE = Color(0xFFFFFFFF);
  static const BLACK = Color(0xFF000000);
  static const TRANS_BACK = Color(0xFF24262B);
  static const TEXT_SECONDARY = Color(0xFF2D2D2D);
  static const ICON_SECONDARY = Color(0xFF50535B);
  static const SECONDARY = Color(0xFF5E96E5);
  static const WHITE_SHADOW = Color(0xFFE7E7E7);
  static const PRIMARY_BACK = Color(0xFF1A4D1F);
  static const SHADOW_GRAY  = Color(0xFF393C43);

  static parse(int i) {
    return Color(i);
  }
}