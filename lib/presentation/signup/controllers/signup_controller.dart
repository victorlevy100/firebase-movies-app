import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_movies_app/core/service/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class SignupController {
  final signupFormKey = GlobalKey<FormState>();

  Future<(String? error, bool success)> onSignup(String email, String password) async {
    if(signupFormKey.currentState!.validate()) {
      final (String? error, UserCredential? user) = 
        await FirebaseAuthService.signup(email, password);
      
      if (error == null && user != null) {
        return (null, true);
      }
      return (error ?? 'Erro desconhecido no registro', false);
    }
    return ('Formulário inválido', false);
  }
}
