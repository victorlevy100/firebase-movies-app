import 'package:flutter/material.dart';

mixin LoginTextEditingControllersMixin {
  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();

  void disposeLoginTECs() {
    emailTEC.dispose();
    passwordTEC.dispose();
  }
}