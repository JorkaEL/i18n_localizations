# i18n_localizations

A flutter package for internationalization, it allows you to simply add the translation of the application according to the language of the device, it uses json files as angular.
You only need to configure it properly to be able to translate your entire app.

## Getting Started

Follow the next step for use i18n_localizations

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
      pathFile: '{translateDir}'
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
    "child_one": "child 1",
    "child_two": {
      "grandchild": "grandchild of key"
    }
  },
  "keyParams": "keyParams have a params or a {key}"
}
```
> **Note:** there should be no space between the key and the parameter hooks


