import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sahayak_ui/screens/login/loginscreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        'assets/images/Synap-Note gif.gif',
        height: 2000,
        width: 2000,
      ),

      backgroundColor: Colors.white,
      nextScreen: LoginScreen(),
      splashIconSize: 2000,
      duration: 3500,
    );
  }
}