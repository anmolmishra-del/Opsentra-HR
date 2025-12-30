import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsentra_hr/features/language/state/language_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(locale: const Locale('en'))) {
    _loadLocale();
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('language_code') ?? 'en';
    emit(LanguageState(locale: Locale(code)));
  }

  void changeLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    emit(LanguageState(locale: locale));
  }
}
