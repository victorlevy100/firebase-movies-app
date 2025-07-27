import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_movies_app/core/service/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:firebase_movies_app/data/models/favorite_movie_model.dart';
import 'package:firebase_movies_app/data/models/movie_model.dart';

const FAVORITE_MOVIES_COLLECTION_KEY = 'favoriteMovies';

class FirebaseStoreService {
  final moviesAppCollection = FirebaseFirestore.instance.collection('moviesapp');

  Future<String?> addFavoriteMovie(MovieModel movie) async {
    try {
      await moviesAppCollection
          .doc(FirebaseAuthService.getUser!.uid)
          .collection(FAVORITE_MOVIES_COLLECTION_KEY)
          .add(movie.toMap());
      return null;
    } on FirebaseException {
      return 'Erro ao adicionar o filme aos favoritos';
    }
  }
  Stream<List<FavoriteMovieModel>> get getFavoriteMovies => moviesAppCollection
      .doc(FirebaseAuthService.getUser!.uid)
      .collection(FAVORITE_MOVIES_COLLECTION_KEY)
      .snapshots()
      .map(_getMoviesListFromSnapshot);

  List<FavoriteMovieModel> _getMoviesListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((favoriteMovie) => FavoriteMovieModel.fromMap(favoriteMovie.data(), favoriteMovie.id)).toList();
  }

  Future<(String? error, String? successMessage)> removeFavoriteMovie(FavoriteMovieModel favoriteMovie) async {
    try {
      await moviesAppCollection.doc(FirebaseAuthService.getUser!.uid).collection(FAVORITE_MOVIES_COLLECTION_KEY).doc(favoriteMovie.favoriteId).delete();
      return (null, 'Filme removido dos favoritos com sucesso');
    } on FirebaseException {
      return ('Erro ao remover o filme dos favoritos', null);
    }
  }
}