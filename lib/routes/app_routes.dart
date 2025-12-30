import 'package:flutter/material.dart';
import 'package:opsentra_hr/features/auth/presentation/login_screen.dart';
import 'package:opsentra_hr/features/main/presentation/main_page.dart';
import 'package:opsentra_hr/features/onboarding/presentation/onboarding_screen.dart';

class Routes {
  Routes._();

  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String main = '/main';

  static Map<String, WidgetBuilder> getAll() {
    return {
      onboarding: (_) =>  OnboardingScreen(),
      login: (_) =>  LoginScreen(),

     
      main: (_) =>  MainScreen(),
    };
  }
}
