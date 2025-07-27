import 'package:firebase_movies_app/core/mixins/loading_error_mixin.dart';
import 'package:firebase_movies_app/core/service/video_player/i_video_player.dart';
import 'package:firebase_movies_app/core/widgets/others/error_with_button_widget/error_with_button_widget.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/movies_widget_controller.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controllers.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/movies_widget/movies_carousel_widget.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/movies_widget/movies_cinema_seats_image_widget.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/movies_widget/movies_youtube_playerr_widet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_movies_app/core/const/assets_paths_const.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/enums/sizes_enum.dart';

class MoviesWidget extends StatefulWidget {
  const MoviesWidget({super.key});

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> with LoadingErrorMixin {
  final _moviesCarouselCtrl = PageController(viewportFraction: 0.4);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moviesCarouselCtrl.addListener(changeVideoPageListner);
      getMoviesAndInitVideo();
    });
    super.initState();
  }

  void changeVideoPageListner() {
    final navCtrl = Provider.of<NavControllers>(context, listen: false);
    final moviesWidgetCtrl = Provider.of<MoviesWidgetController>(
      context,
      listen: false,
    );

    setState(() {
      moviesWidgetCtrl.currentPage = _moviesCarouselCtrl.page ?? 0;
    });
    if (moviesWidgetCtrl.currentPage.round() == moviesWidgetCtrl.currentPage) {
      initVideo(navCtrl.moviesList[
        moviesWidgetCtrl.currentPage.round()
      ].videoId);
    }
  }

  void initVideo([String? videoId]) async {
    final navCtrl = Provider.of<NavControllers>(context, listen: false);
    final videoPlayerCtrl = Provider.of<IVideoPlayer<YoutubePlayerController>>(
      context,
      listen: false,
    );
    final firstVideoWihId = navCtrl.moviesList.firstWhere(
      (video) => video.videoId != null,
    );
    videoPlayerCtrl.load(videoId ?? firstVideoWihId.videoId!);
  }

  Future<void> getMoviesAndInitVideo() async{
    final navCtrl = Provider.of<NavControllers>(context, listen: false);
    setError(null);
    setIsLoading(true);
    final error = await navCtrl.getMovies();
    setIsLoading(false);
    setError(error);
    if (error == null) {
      initVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final navCtrl = Provider.of<NavControllers>(context);
    final moviesWidgetCtrl = Provider.of<MoviesWidgetController>(context);
    return OrientationBuilder(
      builder: (_, Orientation orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return errorMessage != null ? ErrorWithButtonWidget(
          errorMessage: errorMessage!,
          tryAgain: getMoviesAndInitVideo,
        ): Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if(!isLoading) MoviesYoutubePlayerWidget(isPortrait: isPortrait),
            if(isPortrait) const MoviesCinemaSeatsImageWidget(),
            if(isLoading) const Center(
              child: CircularProgressIndicator(),
            ),
            if(!isLoading && navCtrl.moviesList.isNotEmpty)
            MoviesCarouselWidget(
              currentPage: moviesWidgetCtrl.currentPage,
              isPortrait: isPortrait,
              moviesCarouselCtrl: _moviesCarouselCtrl,
            ),
            if (_moviesCarouselCtrl.hasClients &&
                    moviesWidgetCtrl.currentPage.round() !=
                        _moviesCarouselCtrl.page)
                  Positioned(
                    left: context.getWidth / 2 - 100,
                    top:
                        context.getTopPadding +
                        kToolbarHeight -
                        SizesEnum.xxxl.getSize,
                    child: Lottie.asset(
                      AssetsPathsConst.animationPopcorn,
                      width: 200,
                      repeat: true,
                      animate: true,
                    ),
                  )
          ],
        );
      },
    );
  }
}
