import 'package:firebase_movies_app/core/config/firebase_movies_app_colors.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final bool isBlock;
  final bool isLoading;
  final void Function() onPressed;

  const ButtonWidget({
    super.key,
    required this.label,
    this.isBlock = false,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: FirebaseMoviesAppColors.secondaryColor.withValues(alpha: isLoading ? .6 : 1),
          fixedSize: isBlock ? Size(constraints.maxWidth, 50) : null,
        ),
        onPressed: onPressed, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget.normal(label),
            if (isLoading)
              ...[
                const SizedBoxWidget.md(),
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(),
                )
              ]
          ],
        )
      );
    });
  }
}
