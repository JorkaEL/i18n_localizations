import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class I18nLocalizations {
  final Locale locale;
  final List<Locale> supportedLocales;
  final String pathFile;
  Map<dynamic, dynamic> localizedMap;

  I18nLocalizations(this.locale, this.supportedLocales, this.pathFile);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static I18nLocalizations of(BuildContext context) {
    return Localizations.of<I18nLocalizations>(context, I18nLocalizations);
  }

  Future<bool> load() async {
    // Load the language JSON file from the "pathFile" folder
    String jsonString =
        await rootBundle.loadString('$pathFile/${locale.languageCode}.json');
    localizedMap = json.decode(jsonString);

    return true;
  }

  /// This method will be called from every widget which needs a localized text
  static String translate(BuildContext context, String key,
      {final Map<String, String> params}) {
    String translation = _decodeFromMap(
        Localizations.of<I18nLocalizations>(context, I18nLocalizations)
            .localizedMap,
        key);

    if (params != null) {
      translation = _addParams(translation, params);
    }

    return translation;
  }

  // Parse the json file load for create a map whit subMap
  static String _decodeFromMap(Map<dynamic, dynamic> map, final String key) {
    final Map<dynamic, dynamic> subMap = _createSubMap(map, key);
    final String lastKey = key.split(".").last;
    return subMap[lastKey];
  }

  // Create subMap if the key have multi part split by '.'
  static Map<dynamic, dynamic> _createSubMap(
      Map<dynamic, dynamic> map, final String key) {
    final List<String> translationKeySplitted = key.split(".");
    translationKeySplitted.removeLast();
    translationKeySplitted.forEach((listKey) =>
        map = map != null && map[listKey] != null ? map[listKey] : new Map());
    return map;
  }

  // translate in the string paramKey to the value of the paramKey
  static String _addParams(
      String translation, final Map<String, String> params) {
    for (final String paramKey in params.keys) {
      translation =
          translation.replaceAll(new RegExp('{$paramKey}'), params[paramKey]);
    }
    return translation;
  }
}
