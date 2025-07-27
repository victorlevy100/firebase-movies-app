import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/service/video_player/i_video_player.dart';
import 'package:firebase_movies_app/core/widgets/images/network_movie_image_widget.dart';
import 'package:firebase_movies_app/presentation/movie_details/screens/movie_details_screen.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MoviesCarouselWidget extends StatelessWidget {
  final bool isPortrait;
  final double currentPage;
  final PageController moviesCarouselCtrl;


  const MoviesCarouselWidget({
    super.key,
    required this.isPortrait,
    required this.currentPage,
    required this.moviesCarouselCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Provider.of<NavControllers>(context);
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height:
          isPortrait
              ? context.getHeight * 0.35
              : context.getHeight * 0.5, // Altura específica
      child: Stack(
        children: [
          PageView.builder(
            controller: moviesCarouselCtrl,
            itemCount: navCtrl.moviesList.length,
            itemBuilder: (_, int index) {
              final selectedMovie = navCtrl.moviesList[index];
              final scale = 1/((index - currentPage).abs() + 1);
              return Align(
                alignment: Alignment.bottomCenter,
                child: Transform.scale(
                  alignment: Alignment.center,
                  scale: scale,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: isPortrait ? 0 : 50,
                      bottom: isPortrait ? SizesEnum.md.getSize : 50,
                    ),
                    child: InkWell(
                      onTap: (){
                        Provider.of<IVideoPlayer<YoutubePlayerController>>(context, listen: false).pause();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MovieDetailsScreen(),
                            settings: RouteSettings(
                              arguments: selectedMovie
                            )
                          )
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(SizesEnum.md.getSize),
                        child: Hero(
                          tag: 'movies-picture-${selectedMovie.id}', 
                          child: NetworkMovieImageWidget(
                            movieImage: selectedMovie.imagePath,
                          )
                        ),
                      ),
                    ), 
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
