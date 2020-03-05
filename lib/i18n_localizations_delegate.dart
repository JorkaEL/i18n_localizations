import 'package:flutter/material.dart';
import 'package:i18n_localizations/i18n_localizations.dart';


// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an I18nLocalizations object
class I18nLocalizationsDelegate extends LocalizationsDelegate<I18nLocalizations> {
  final List<Locale> supportedLocales;
  final String pathFile;
  static I18nLocalizations localizations;

  I18nLocalizationsDelegate({this.supportedLocales, this.pathFile});

  @override
  bool isSupported(Locale locale) {
    return _languageCodeSuppotedLocales().contains(locale.languageCode);
  }

  @override
  Future<I18nLocalizations> load(Locale locale) async {
    // I18nLocalizations class is where the JSON loading actually runs
    localizations = I18nLocalizations(locale, supportedLocales, pathFile);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(I18nLocalizationsDelegate old) => false;

  localeResolutionCallback(Locale locale) {
    // Check if the current device locale is supported
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    // If the locale of the device is not supported, use the first one
    return supportedLocales.first;
  }

  // Map the languageCode from the supportedLocales
  _languageCodeSuppotedLocales() {
    return supportedLocales.map((locale) => locale.languageCode);
  }
}