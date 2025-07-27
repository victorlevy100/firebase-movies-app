import 'package:firebase_movies_app/data/models/movie_model.dart';
import 'package:firebase_movies_app/data/repositories/movies_repository/get_movies_repository.dart';
import 'package:flutter/material.dart';

class NavControllers extends ChangeNotifier {
  final GetMoviesRepository _getMoviesRepo;

  NavControllers(this._getMoviesRepo);

  int navIndex = 0;

  final List<MovieModel> moviesList = [];

  String get getTitle {
    if (navIndex == 0) {
      return 'Filmes';
    }
    return 'Filmes Favoritos';
  }

  void selectNavIndex(int index) {
    navIndex = index;
    notifyListeners();
  }

  Future<String?> getMovies() async {
    final (String? errorLoadingMovies, List<MovieModel> movies) =
        await _getMoviesRepo.getMovies();

    moviesList
      ..clear()
      ..addAll(movies);

    notifyListeners();

    return errorLoadingMovies; 
  }
}
