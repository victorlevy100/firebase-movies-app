import 'package:firebase_movies_app/core/service/video_player/i_video_player.dart';
import 'package:firebase_movies_app/core/service/video_player/youtube_player_impl.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

final makeVideoPlayer = Provider<IVideoPlayer<YoutubePlayerController>>(
  create: (_) => YoutubePlayerImpl(
    youtubePlayerCtrl: YoutubePlayerController()
  ),
);