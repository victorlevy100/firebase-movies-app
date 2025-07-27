import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/extensions/dates/datess_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/mixins/snack_bar_mixin.dart';
import 'package:firebase_movies_app/core/widgets/buttons/favorite_icon_button_widget.dart';
import 'package:firebase_movies_app/core/widgets/images/network_movie_image_widget.dart';
import 'package:firebase_movies_app/core/widgets/others/star_rating/star_rating_widget.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/data/models/favorite_movie_model.dart';
import 'package:firebase_movies_app/data/models/movie_model.dart';
import 'package:firebase_movies_app/presentation/movie_details/controllers/movie_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreenWidget extends StatefulWidget {
  const MovieDetailsScreenWidget({super.key});

  @override
  State<MovieDetailsScreenWidget> createState() =>
      _MovieDetailsScreenWidgetState();
}

class _MovieDetailsScreenWidgetState extends State<MovieDetailsScreenWidget>
    with SnackBarMixin {
  void toggleFavorite(
    bool isFavorite,
    MovieDetailsController movieDetailsCtrl,
    MovieModel movie,
  ) async {
    final (errorMessage, successMessage) = await movieDetailsCtrl
        .toggleFavoriteMovie(context, isFavorite, movie);
    if (context.mounted) {
      showSnackBar(
        context,
        errorMessage ?? successMessage!,
        errorMessage != null ? MessageType.error : MessageType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieArgs = ModalRoute.of(context)?.settings.arguments;
    if (movieArgs == null) {
      return const Scaffold(
        body: Center(child: Text('Erro: Filme não encontrado')),
      );
    }
    final movie = movieArgs as MovieModel;
    final movieDetailsCtrl = Provider.of<MovieDetailsController>(context);
    final favoriteMovies = context.watch<List<FavoriteMovieModel>>();
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Hero(
                  tag: 'movie-picture-${movie.id}',
                  child: NetworkMovieImageWidget(
                    movieImage: movie.imagePath,
                    height: context.getHeight,
                    boxFit: BoxFit.cover,
                  ),
                ),
                collapsedHeight: context.getHeight,
                stretch: true,
              ),
            ],
          ),
          Positioned(
            top: context.getHeight / 2.5,
            width: context.getWidth,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: .8),
                    Colors.black.withValues(alpha: .9),
                    Colors.black.withValues(alpha: .95),
                    Colors.black,
                  ],
                ),
              ),
              height: context.getHeight / 1.5,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  SizesEnum.md.getSize,
                  SizesEnum.md.getSize * 2.5,
                  SizesEnum.md.getSize,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget.title(movie.title, textAlign: TextAlign.center),
                    const SizedBoxWidget.xs(),
                    TextWidget.small(
                      'Nos cinemas dia ${movie.releaseDate.convertToDateDDMMAAAA()}',
                    ),
                    const SizedBoxWidget.md(),
                    StarRatingWidget(rating: (movie.voteAverage / 2).round()),
                    const SizedBoxWidget.lg(),
                    TextWidget.title('Sinopse'),
                    const SizedBoxWidget.md(),
                    TextWidget.normal(
                      movie.overview,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBoxWidget.lg(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: context.getTopPadding + 2,
            right: 16,
            child: FavoriteIconButtonWidget(
              isFavorite: favoriteMovies.indexWhere((favoriteMovie) => favoriteMovie.id == movie.id) != -1,
              onPressed: (bool isFavorite) {
                toggleFavorite(isFavorite, movieDetailsCtrl, movie);
              },
            ),
          )
        ],
      ),
    );
  }
}
