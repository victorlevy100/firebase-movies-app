import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/service/video_player/i_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MoviesYoutubePlayerWidget extends StatelessWidget {
  final bool isPortrait;

  const MoviesYoutubePlayerWidget({super.key, required this.isPortrait});

  @override
  Widget build(BuildContext context) {
    final videoPlayerCtrl = Provider.of<IVideoPlayer<YoutubePlayerController>>(context, listen: false);
    return Positioned(
      width: context.getWidth,
      height: isPortrait ? context.getHeight * 0.4 : context.getHeight * 0.5, // Limitar altura
      top: context.getTopPadding + kToolbarHeight - SizesEnum.xxxl.getSize,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isPortrait ? SizesEnum.sm.getSize : 0,
          vertical: SizesEnum.sm.getSize,
        ),
        child: YoutubePlayer(
          controller: videoPlayerCtrl.getController,
          aspectRatio: 16/9,
          backgroundColor: Colors.black, 
        ), 
      ),
    );
  }
}