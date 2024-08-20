import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('en'); // Default locale

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return; // Check if the locale is supported
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = Locale('en'); // Reset to default
    notifyListeners();
  }
}

class L10n {
  static final all = [
    Locale('en'),
    Locale('es'),
    // Add other supported locales here
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'es':
        return '🇪🇸';
      default:
        return '🏳️';
    }
  }
}
