import 'package:firebase_movies_app/core/factories/video_player_factory.dart';
import 'package:firebase_movies_app/core/service/firebase/firebase_store/firebase_store_service.dart';
import 'package:firebase_movies_app/data/models/favorite_movie_model.dart';
import 'package:firebase_movies_app/presentation/nav/factories/movies_widget_controller_factory.dart';
import 'package:firebase_movies_app/presentation/nav/factories/nav_controller_factory.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/nav/nav_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        makeNavController(context),
        makeVideoPlayer,
        makeMoviesWidgetController,
        StreamProvider.value(
          value: FirebaseStoreService().getFavoriteMovies,
          initialData: const <FavoriteMovieModel>[],
        ),
      ],
      child: const NavScreenWidget(),
    );
  }
}
