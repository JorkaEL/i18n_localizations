import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i18n_localizations/i18n_localizations_delegate.dart';

void main() {
  group('i18nLocalizationsDelegate', () {
    List<Locale> supportedLocales = [Locale('en', 'US')];
    String pathFile = 'test';
    final i18n = I18nLocalizationsDelegate(
        supportedLocales: supportedLocales,
        pathFile: pathFile);

    test('i18nLocalizationsDelegate shouln\'t be null', () {
      expect(null, isNot(equals(i18n)));
    });

    test('pathFile should be "test"', () {
      expect(i18n.pathFile, equals('test'));
    });

    test('supportedLocales should be [Locale("en", "US")]', () {
      expect(i18n.supportedLocales, equals([Locale('en', 'US')]));
    });

    test('pathFile shouldn\'t be "no test"', () {
      expect(i18n.pathFile, isNot(equals('no test')));
    });

    test('supportedLocales shouldn\'t be [Locale("en", "US"), Locale("fr", "FR")]', () {
      expect(i18n.supportedLocales, isNot(equals([Locale('en', 'US'), Locale('fr', 'FR')])));
    });

  });
}
