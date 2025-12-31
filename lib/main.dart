import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/Core/constants/app_assets.dart';
import 'package:opsentra_hr/Core/constants/app_colors.dart';

import 'package:opsentra_hr/features/language/cubit/language_cubit.dart';
import 'package:opsentra_hr/features/language/state/language_state.dart';
import 'package:opsentra_hr/l10n/app_localizations.dart';

import 'package:opsentra_hr/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔔 Background message: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);
  runApp(BlocProvider(create: (_) => LanguageCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Opsentra-HR',

          locale: context.watch<LanguageCubit>().state.locale,

          supportedLocales: const [Locale('en'), Locale('hi'), Locale('te')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          theme: ThemeData(useMaterial3: true),
          routes: Routes.getAll(),
          home: const SplashScreen(),
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();

    final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, Routes.main);
    } else {
      Navigator.pushReplacementNamed(context, Routes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Image.asset(
        height: MediaQuery.of(context).size.height,
        AppImage.logo,
        fit: BoxFit.fill,
      ),
    );
  }
}
