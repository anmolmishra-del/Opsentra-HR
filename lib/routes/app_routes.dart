import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/features/auth/presentation/login_screen.dart';
import 'package:opsentra_hr/features/home/presentation/home_page.dart';
import 'package:opsentra_hr/features/main/presentation/main_page.dart';
import 'package:opsentra_hr/features/onboarding/presentation/onboarding_screen.dart';
import 'package:opsentra_hr/features/profile/cubit/profile_cubit.dart';
import 'package:opsentra_hr/features/profile/presentation/edit_profile.dart';

class Routes {
  Routes._();

  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String main = '/main';
  static const String home = '/home';
  static const String editProfile = '/edit-profile';

  static Map<String, WidgetBuilder> getAll() {
    return {
      onboarding: (_) => OnboardingScreen(),
      login: (_) => LoginScreen(),
      home: (_) => HomeScreen(),
      main: (_) => MainScreen(),
      editProfile: (_) => BlocProvider(
        create: (context) => ProfileCubit(),
        child: EditProfilePage(),
      ),
    };
  }
}
