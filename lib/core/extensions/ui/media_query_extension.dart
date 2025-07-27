import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  double get getHeight => MediaQuery.sizeOf(this).height;
  double get getWidth => MediaQuery.sizeOf(this).width;
  double get getBottomPadding => MediaQuery.paddingOf(this).bottom;
  double get getTopPadding => MediaQuery.paddingOf(this).top;
}