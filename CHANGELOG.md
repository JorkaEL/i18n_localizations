## [1.1.2] - 10 October 2020
Add Note for ios in README.md

Add return type Locale to methode localeResolutionCallback

## [1.1.1] - 24 May 2020
Add Options for CountryCode

```yaml
assets:
  - {translateDir}/en.json
  - {translateDir}/fr.json
  - {translateDir}/{languageCode}.json
  or
  - {translateDir}/en_US.json
  - {translateDir}/fr_FR.json
  - {translateDir}/{languageCode}_${countryCode}.json
```

```dart
final I18nLocalizationsDelegate i18n = I18nLocalizationsDelegate(
      supportedLocales: [Locale('en'), Locale('fr')],
      pathFile: '{translateDir}'
  );
  or
  final I18nLocalizationsDelegate i18n = I18nLocalizationsDelegate(
        supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR')],
        pathFile: '{translateDir}',
        haveCountryCode: true
    );
```

## [1.1.0] - 6 Mars 2020
Add Plural by function translatePlural

```dart
I18nLocalizations.translatePlural(context,"keyPlural", params:{"key":"6"})
I18nLocalizations.translatePlural(context,"keyPlural", params:{"key":"1"})
I18nLocalizations.translatePlural(context,"keyPlural", params:{"key":"not a number"})
```
And the json file will look like:
```dart
{
  "keyPlural": {
    "none": "there are none key here",
    "one": "the value of our key is {key}",
    "many": "we have {key} keys"
  }
}
```
> **Note:** there should be no space between the key and the parameter hooks


## [1.0.2] - 6 MARS 2020
Add Example

## [1.0.1] - 5 MARS 2020
Format file lib

## [1.0.0] - 5 MARS 2020


*i18n_localizations* allows you to simply add the translation of the application according to the language of the device, it uses json files as angular.
You only need to configure it properly to be able to translate your entire app.

## Configuration
To use this library, you wiil need json file you can put there where you want, but don't forget to add them to your pubspec.yaml
```yaml
assets:
  - {translateDir}/en.json
  - {translateDir}/fr.json
  - {translateDir}/{languageCode}.json
```

You need to initialize a I18nLocalizationsDelegate white a list of supportedLocales and a pathFile where the json file are store.
```dart
final I18nLocalizationsDelegate i18n = I18nLocalizationsDelegate(
      supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR')],
      pathFile: '{translateDir}'
  );
```

Then you need to configure the supportedLocales, localizationsDelegates and localeResolutionCallback of your MaterialApp or CupertinoApp
```dart
  supportedLocales: i18n.supportedLocales,
  localizationsDelegates: [
   i18n,
   GlobalMaterialLocalizations.delegate,
   GlobalWidgetsLocalizations.delegate
  ],
  localeResolutionCallback: (Locale locale, supportedLocales) {
    return i18n.localeResolutionCallback(locale);
  },
```


> Result

```dart
// construct the i18nLocalisationsDelegate
final I18nLocalizationsDelegate i18n = I18nLocalizationsDelegate(
      supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR')],
      pathFile: 'assets/i18n'
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyApp',
        onGenerateRoute: router.generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePageRoute,
        // set the supportedLocales for the app
        supportedLocales: i18n.supportedLocales,
        localizationsDelegates: [
         // don't forget to put the delegate
          i18n,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (Locale locale, supportedLocales) {
           // get the default local when the device language is not supported, use the first one
          // from the list (English, in this case).
          return i18n.localeResolutionCallback(locale);
        },
    );
  }
```

## Use

To use I18nLocalizations, just call :
```dart
I18nLocalizations.translate(context,"keySimple")
I18nLocalizations.translate(context,"key.child_one")
I18nLocalizations.translate(context,"key.child_two.grandchild")

I18nLocalizations.translate(context,"keyParams", params:{"key": "value"})

```
And the json file will look like:
```dart
{
  "keySimple": "key simple",
  "key": {
    child_one: "child 1",
    child_two: {
      grandchild: "grandchild of key"
    }
  },
  "keyParams": "keyParams have a params or a {key}"
}
```
> **Note:** there should be no space between the key and the parameter hooks




