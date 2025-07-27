import 'package:firebase_movies_app/core/config/firebase_movies_app_colors.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

enum MessageType {
  success,
  error
}

mixin SnackBarMixin {
  void showSnackBar(BuildContext context, String message, MessageType messageType){
    ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: TextWidget.normal(message),
        backgroundColor: messageType == MessageType.error 
          ? FirebaseMoviesAppColors.errorColor
          : FirebaseMoviesAppColors.successColor,
      ),
    );
  }
}