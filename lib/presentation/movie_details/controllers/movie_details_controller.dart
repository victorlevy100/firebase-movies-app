import 'package:firebase_movies_app/core/service/firebase/firebase_store/firebase_store_service.dart';
import 'package:firebase_movies_app/data/models/favorite_movie_model.dart';
import 'package:firebase_movies_app/data/models/movie_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MovieDetailsController {
  final FirebaseStoreService _firebaseStoreService;

  MovieDetailsController(this._firebaseStoreService);

  Future<(String? errorToggleFavoriteMovie, String? successToggleFavoriteMovie)>
  toggleFavoriteMovie(
    BuildContext context,
    bool isFavorite,
    MovieModel movie,
  ) async {
    String? responseErrorMessage;
    String? responseSuccessMessage;

    if (!isFavorite) {
      List<FavoriteMovieModel> favoriteMovies = [];
      if (context.mounted) {
        favoriteMovies = Provider.of<List<FavoriteMovieModel>>(
          context,
          listen: false,
        );
      }
      final favoriteMovieIndex = favoriteMovies.indexWhere(
        (favoriteMovie) => favoriteMovie.id == movie.id,
      );
      if (favoriteMovieIndex != -1) {
        final favoriteMovie = favoriteMovies[favoriteMovieIndex];
        final (
          String? errorRemovingFavoriteMovieMessage,
          String? successRemovingFavoriteMovieMessage,
        ) = await _firebaseStoreService.removeFavoriteMovie(favoriteMovie);

        responseErrorMessage = errorRemovingFavoriteMovieMessage;
        responseSuccessMessage = successRemovingFavoriteMovieMessage;
      } else {
        responseErrorMessage = 'Esse filme não está na sua lista de favoritos.';
      }
    } else {
      final String? errorAddingFavoriteMovieMessage = await _firebaseStoreService.addFavoriteMovie(movie);
      responseErrorMessage = errorAddingFavoriteMovieMessage;
      if (errorAddingFavoriteMovieMessage == null) {
        responseSuccessMessage = 'Filme adicionado aos favoritos com sucesso!';
      }
    }
    return (responseErrorMessage, responseSuccessMessage);
  }
}
