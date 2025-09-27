import 'package:flutter/material.dart';
import 'package:sahayak_ui/splash/splashscreen.dart';
import 'package:sahayak_ui/utils/app_theme.dart';

void main() {
  runApp(SahayakApp());
}

class SahayakApp extends StatelessWidget {
  SahayakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
