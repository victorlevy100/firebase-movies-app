import 'package:flutter/material.dart';

mixin LoginFocusNodesMixin {
  final emailFN = FocusNode();
  final passwordFN = FocusNode();

  void disposeFocusNodes() {
    emailFN.dispose();
    passwordFN.dispose();
  }
}