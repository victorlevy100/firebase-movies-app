import 'package:firebase_movies_app/core/config/firebase_movies_app_colors.dart';
import 'package:firebase_movies_app/core/config/firebase_movies_app_text_styles.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final Color? color;
  final TextOverflow? overflow;
  final int? maxLines;

  const TextWidget(
    this.text, {
    super.key,
    required this.style,
    this.textAlign,
    this.color,
    this.overflow,
    this.maxLines,
  });

  TextWidget.bold(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
    this.color,
    this.overflow,
    this.maxLines,
  }) : style = textStyle ?? FirebaseMoviesAppTextStyles.getNormalBoldStyle;

  TextWidget.title(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
    this.color,
    this.overflow,
    this.maxLines,
  }) : style = textStyle ?? FirebaseMoviesAppTextStyles.getTitleStyle;

  TextWidget.normal(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
    this.color,
    this.overflow,
    this.maxLines,
  }) : style = textStyle ?? FirebaseMoviesAppTextStyles.getNormalStyle;
  
  TextWidget.small(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
    this.color,
    this.overflow,
    this.maxLines,
  }) : style = textStyle ?? FirebaseMoviesAppTextStyles.getSmallStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: color ?? FirebaseMoviesAppColors.whiteColor,
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
