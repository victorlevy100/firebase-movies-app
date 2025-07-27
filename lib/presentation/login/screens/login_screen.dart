import 'package:firebase_movies_app/core/const/assets_paths_const.dart';
import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/mixins/loading_error_mixin.dart';
import 'package:firebase_movies_app/core/mixins/navigation_mixin.dart';
import 'package:firebase_movies_app/core/mixins/snack_bar_mixin.dart';
import 'package:firebase_movies_app/core/validators/email_validator.dart';
import 'package:firebase_movies_app/core/validators/password_validator.dart';
import 'package:firebase_movies_app/core/widgets/buttons/button_widget.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/widgets/inputs/text_form_field_widget.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/presentation/login/controllers/login_controller.dart';
import 'package:firebase_movies_app/presentation/login/mixins/login_focus_nodes_mixin.dart';
import 'package:firebase_movies_app/presentation/login/mixins/login_text_editting_controllers.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:firebase_movies_app/presentation/signup/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with
        LoginFocusNodesMixin,
        LoginTextEditingControllersMixin,
        NavigationMixin,
        LoadingErrorMixin,
        SnackBarMixin {
  late LoginController loginCtrl;
  
  @override
  void initState() {
    loginCtrl = LoginController();
    setIsLoading(false);

    super.initState();
    // Initialize focus nodes and text editing controllers here if needed
  }

  void onLogin() async {
    setIsLoading(true);
    final error = await loginCtrl.onLogin(emailTEC.text, passwordTEC.text);

    if(error != null && mounted) {
      setIsLoading(false);
      showSnackBar(context, error, MessageType.error);
    } else if (mounted) {
      handleNavigation(context, NavScreen.routeName, clear: true);
    }
  }

  @override
  void dispose() {
    disposeFocusNodes();
    disposeLoginTECs();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginCtrl.loginFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizesEnum.lg.getSize),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBoxWidget.lg(),
                  SizedBox(
                    width: 150, 
                    height: 150, 
                    child: Lottie.asset(AssetsPathsConst.loginAnimation)
                  ),
                  const SizedBoxWidget.md(),
                  TextWidget.title('Firebase Movies App'),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    inputLabel: 'Email',
                    controller: emailTEC,
                    focusNode: emailFN,
                    validator: EmailValidator.validate,
                    textInputType: TextInputType.emailAddress,
                    onFieldSubmitted: (_) => passwordFN.requestFocus(),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    inputLabel: 'Password',
                    controller: passwordTEC,
                    focusNode: passwordFN,
                    isPassword: true,
                    validator: PasswordValidator.validate,
                    onFieldSubmitted: (_) => onLogin(),
                    textInputAction: TextInputAction.go,
                  ),
                  const SizedBoxWidget.xxl(),
                  ButtonWidget(
                    label: 'Login',
                    onPressed: onLogin,
                    isBlock: true,
                    isLoading: isLoading,
                  ),
                  const SizedBoxWidget.lg(),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16),
                      children: [
                        const TextSpan(text: 'Ainda não tem uma conta? '),
                        TextSpan(
                          text: 'Registre aqui!',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                              handleNavigation(context, SignupScreen.routeName),
                        ),
                      ]
                    ) 
                  ),
                  const SizedBoxWidget.lg(),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
