import 'package:calculator/calculator_screen.dart';
import 'package:calculator/splash%20animation/splash_animation.dart';
import 'package:flutter/material.dart';



class RouteGenerator {

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case '/calculator':
        return MaterialPageRoute(
          builder: (_) => const CalculatorScreen(),
          settings: settings,
        );
      default: ///Home
        return MaterialPageRoute(
            builder: (_) => const CalculatorScreen(),
            settings: settings
        );
    }
  }
}