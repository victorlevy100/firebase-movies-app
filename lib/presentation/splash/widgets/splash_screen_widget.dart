import 'package:firebase_movies_app/core/const/assets_paths_const.dart';
import 'package:firebase_movies_app/core/mixins/navigation_mixin.dart';
import 'package:firebase_movies_app/core/service/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/presentation/login/screens/login_screen.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> with NavigationMixin {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      final user = FirebaseAuthService.getUser;

      if(mounted) {
        if (user == null) {
          handleNavigation(context, LoginScreen.routeName, clear: true);
        } else {
          handleNavigation(context, NavScreen.routeName, clear: true);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Lottie.asset(AssetsPathsConst.splashAnimation),
          ),
          const SizedBoxWidget.md(),
          TextWidget.title('Loading...')
        ],
      ),
    );
  }
}