import 'package:flutter/material.dart';
import 'package:i18n_localizations/i18n_localizations.dart';

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an I18nLocalizations object
class I18nLocalizationsDelegate
    extends LocalizationsDelegate<I18nLocalizations> {
  final List<Locale> supportedLocales;
  final String pathFile;
  final bool haveCountryCode;
  static I18nLocalizations localizations;

  I18nLocalizationsDelegate(
      {this.supportedLocales, this.pathFile, this.haveCountryCode = false});

  @override
  bool isSupported(Locale locale) {
    return _languageCodeSupportedLocales().contains(_formatSupported(locale));
  }

  @override
  Future<I18nLocalizations> load(Locale locale) async {
    // I18nLocalizations class is where the JSON loading actually runs
    localizations =
        I18nLocalizations(locale, supportedLocales, pathFile, haveCountryCode);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(I18nLocalizationsDelegate old) => false;

  /// This allows to define which language used when the device language is not supported
  Locale localeResolutionCallback(Locale locale) {
    // Check if the current device locale is supported
    for (var supportedLocale in supportedLocales) {
      if (_isSupportedLocales(supportedLocale, locale)) {
        return supportedLocale;
      }
    }
    // If the locale of the device is not supported, use the first one
    return supportedLocales.first;
  }

  _isSupportedLocales(Locale supportedLocale, Locale locale) {
    bool languageCode = supportedLocale.languageCode == locale.languageCode;
    bool countryCode = supportedLocale.countryCode == locale.countryCode;
    return haveCountryCode ? languageCode && countryCode : languageCode;
  }

  _formatSupported(Locale locale) {
    return haveCountryCode
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;
  }

  // Map the languageCode from the supportedLocales
  _languageCodeSupportedLocales() {
    return supportedLocales.map((locale) => _formatSupported(locale));
  }
}
