import 'package:flutter/material.dart';

class FirebaseMoviesAppColors {
  static final FirebaseMoviesAppColors _singleton = FirebaseMoviesAppColors._internal();

  factory FirebaseMoviesAppColors() {
    return _singleton;
  }

  FirebaseMoviesAppColors._internal();

  static Color get primaryColor => const Color(0xFF000000);

  static Color get secondaryColor => const Color(0xFF2962ff);

  static Color get errorColor => const Color(0xFFdc3545);

  static Color get favoriteColor => Colors.redAccent;

  static Color get whiteColor => const Color(0xFFFFFFFF);

  static Color get successColor => Colors.green;
}