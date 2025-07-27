import 'package:firebase_movies_app/core/config/firebase_movies_app_colors.dart';
import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/mixins/navigation_mixin.dart';
import 'package:firebase_movies_app/core/service/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:firebase_movies_app/core/service/video_player/i_video_player.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/presentation/login/screens/login_screen.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controllers.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/favorites_widget/favorites_widget.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/movies_widget/movies_widget.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/nav/nav_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class NavScreenWidget extends StatefulWidget {
  const NavScreenWidget({super.key});

  @override
  State<NavScreenWidget> createState() => _NavScreenWidgetState();
}

class _NavScreenWidgetState extends State<NavScreenWidget> with NavigationMixin {
  late NavControllers navCtrl;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navCtrl.addListener(navTabIndexChange);
    });
    super.initState();
  }

  @override
  void dispose() {
    navCtrl.removeListener(navTabIndexChange);
    super.dispose();
  }

  void navTabIndexChange() {
    final videoPlayer = Provider.of<IVideoPlayer<YoutubePlayerController>>(
      context,
      listen: false,
    );
    if (navCtrl.navIndex == 0) {
      videoPlayer
        ..getController.unMute()
        ..play();
    } else {
      videoPlayer
        ..mute()
        ..pause();
    }
  }

  void onLogout(BuildContext context) async {
    final String? error = await FirebaseAuthService.logout();
    if(error == null && context.mounted) {
      handleNavigation(context, LoginScreen.routeName, clear: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    navCtrl = context.watch<NavControllers>();
    return Scaffold(
      appBar: AppBar(
        title: TextWidget.normal(navCtrl.getTitle),
        actions: [
          IconButton(
            onPressed: () => onLogout(context),
            icon: const Icon(Icons.exit_to_app_sharp, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(child: MoviesWidget()),
                if (navCtrl.navIndex == 1)
                  const FavoritesWidget(),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: FirebaseMoviesAppColors.primaryColor,
              boxShadow: [BoxShadow(blurRadius: 4, spreadRadius: 3)],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizesEnum.xs.getSize,
                right: SizesEnum.xs.getSize,
                bottom: SizesEnum.xs.getSize + context.getBottomPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavButtonWidget(
                    icon: Icons.movie,
                    onTap: () => navCtrl.selectNavIndex(0),
                    isSelected: navCtrl.navIndex == 0,
                  ),
                  NavButtonWidget(
                    icon: Icons.favorite,
                    onTap: () => navCtrl.selectNavIndex(1),
                    isSelected: navCtrl.navIndex == 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
