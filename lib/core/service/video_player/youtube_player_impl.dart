import 'package:firebase_movies_app/core/service/video_player/i_video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerImpl implements IVideoPlayer<YoutubePlayerController> {
  final YoutubePlayerController youtubePlayerCtrl;

  YoutubePlayerImpl({required this.youtubePlayerCtrl});

  @override
  get getController => youtubePlayerCtrl;

  @override
  Future<void> play() async {
    return youtubePlayerCtrl.playVideo();
  }

  @override
  Future<void> pause() async {
    return youtubePlayerCtrl.pauseVideo();
  }

  @override
  Future<void> mute() async {
    return youtubePlayerCtrl.mute();
  }

  @override
  Future<void> unMute() async {
    return youtubePlayerCtrl.unMute();
  }

  @override
  Future<void> load(String videoId, [bool loop = true]) async {
    return youtubePlayerCtrl.loadVideoById(videoId: videoId);
  }
}
