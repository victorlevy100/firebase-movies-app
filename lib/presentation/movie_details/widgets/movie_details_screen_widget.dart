import 'package:firebase_movies_app/core/config/firebase_movies_app_colors.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight:
                context.getHeight * 0.9, // Aumentar a altura para acomodar o texto
            pinned: true,
            stretch: true,
            backgroundColor: FirebaseMoviesAppColors.primaryColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.white, // Cor da seta de voltar
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    top: kToolbarHeight + MediaQuery.of(context).padding.top,
                    child: Hero(
                      tag: 'movie-picture-${movie.id}',
                      child: NetworkMovieImageWidget(
                        movieImage: movie.imagePath,
                        height: context.getHeight * 0.8, // Ajustar altura da imagem
                        width: context.getWidth,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Gradiente sobrepondo a imagem
                  Positioned.fill(
                    top: kToolbarHeight + MediaQuery.of(context).padding.top,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withValues(alpha: .3),
                            Colors.black.withValues(alpha: .6),
                            Colors.black.withValues(alpha: .9),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Textos sobrepostos à imagem
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height:
                        context.getHeight * 0.5, // Definir altura fixa para a área de texto
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        SizesEnum.md.getSize,
                        SizesEnum.md.getSize * 2, // Aumentar padding top para descer o texto
                        SizesEnum.md.getSize,
                        MediaQuery.of(context).padding.bottom + SizesEnum.xxxs.getSize,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBoxWidget.lg(), // Espaço adicional no topo
                            TextWidget.title(
                              movie.title,
                              textAlign: TextAlign.center,
                              color: Colors.white,
                            ),
                            const SizedBoxWidget.xs(),
                            TextWidget.small(
                              'Nos cinemas dia ${movie.releaseDate.convertToDateDDMMAAAA()}',
                              color: Colors.white70,
                            ),
                            const SizedBoxWidget.md(),
                            StarRatingWidget(
                              rating: (movie.voteAverage / 2).round(),
                            ),
                            const SizedBoxWidget.lg(),
                            TextWidget.title('Sinopse', color: Colors.white),
                            const SizedBoxWidget.md(),
                            TextWidget.normal(
                              movie.overview,
                              textAlign: TextAlign.center,
                              color: Colors.white,
                            ),
                            const SizedBoxWidget.lg(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: FavoriteIconButtonWidget(
                  isFavorite:
                      favoriteMovies.indexWhere(
                        (favoriteMovie) => favoriteMovie.id == movie.id,
                      ) !=
                      -1,
                  onPressed: (bool isFavorite) {
                    toggleFavorite(isFavorite, movieDetailsCtrl, movie);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
