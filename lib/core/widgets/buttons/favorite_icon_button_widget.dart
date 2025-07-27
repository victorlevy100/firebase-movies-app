import 'package:firebase_movies_app/core/config/firebase_movies_app_colors.dart';
import 'package:flutter/material.dart';

class FavoriteIconButtonWidget extends StatelessWidget {
  final void Function(bool) onPressed;
  final bool isFavorite;

  const FavoriteIconButtonWidget({
    super.key,
    required this.onPressed,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(!isFavorite),
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_outline,
        size: 38,
        color:
            isFavorite
                ? FirebaseMoviesAppColors.favoriteColor
                : FirebaseMoviesAppColors.whiteColor,
      ),
    );
  }
}
