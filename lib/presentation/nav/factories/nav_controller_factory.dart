import 'package:firebase_movies_app/data/repositories/api_repository/i_api_repository.dart';
import 'package:firebase_movies_app/data/repositories/movies_repository/get_movie_video_repository.dart';
import 'package:firebase_movies_app/data/repositories/movies_repository/get_movies_repository.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

ChangeNotifierProvider<NavControllers> makeNavController(
  BuildContext context,
) => ChangeNotifierProvider<NavControllers>(
  create:
      (_) => NavControllers(
        GetMoviesRepository(
          Provider.of<IApiRepository>(context),
          GetMovieVideoRepository(
            Provider.of<IApiRepository>(context)
          ),
        ),
      ),
);
