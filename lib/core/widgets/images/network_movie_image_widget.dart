import 'package:firebase_movies_app/core/service/dot_env_service.dart';
import 'package:flutter/material.dart';

class NetworkMovieImageWidget extends StatelessWidget {
  final String movieImage;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const NetworkMovieImageWidget({
    super.key,
    required this.movieImage,
    this.height,
    this.width,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '${DotEnvService.getApiImagesUrl}$movieImage',
      height: height,
      width: width,
      fit: boxFit,
    );
  }
}