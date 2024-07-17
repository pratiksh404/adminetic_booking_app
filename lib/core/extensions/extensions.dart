import 'package:flutter/material.dart';

extension ToColorFilter on Color {
  ColorFilter? get toColorFilter {
    return ColorFilter.mode(this, BlendMode.srcIn);
  }
}

extension ToBoolOnString on String {
  bool toBool() {
    return toLowerCase() == 'true';
  }
}
