import 'package:firebase_movies_app/presentation/login/screens/login_screen.dart';
import 'package:firebase_movies_app/presentation/movie_details/screens/movie_details_screen.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:firebase_movies_app/presentation/signup/screens/signup_screen.dart';
import 'package:firebase_movies_app/presentation/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class FirebaseMoviesAppRoutes {
  static final FirebaseMoviesAppRoutes _singleton = FirebaseMoviesAppRoutes._internal();

  factory FirebaseMoviesAppRoutes() {
    return _singleton;
  }

  FirebaseMoviesAppRoutes._internal();

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      SplashScreen.routeName: (_) {
        return const SplashScreen();
      },
      LoginScreen.routeName: (_) {
        return const LoginScreen();
      },
      SignupScreen.routeName: (_) {
        return const SignupScreen();
      },
      NavScreen.routeName: (_) {
        return const NavScreen();
      },
      MovieDetailsScreen.routeName: (_) {
        return const MovieDetailsScreen();
      },
    };
  }
}