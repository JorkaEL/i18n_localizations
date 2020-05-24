import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_localizations/i18n_localizations.dart';
import 'package:i18n_localizations/i18n_localizations_delegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final I18nLocalizationsDelegate i18n = I18nLocalizationsDelegate(
      supportedLocales: [Locale('en'), Locale('fr')], pathFile: 'assets/i18n');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      supportedLocales: i18n.supportedLocales,
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (Locale locale, supportedLocales) {
        return i18n.localeResolutionCallback(locale);
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              I18nLocalizations.translate(context, "keySimple"),
            ),
            Text(I18nLocalizations.translate(context, "key.child_one")),
            Text(I18nLocalizations.translate(
                context, "key.child_two.grandchild")),
            Text(I18nLocalizations.translate(context, "keyParams",
                params: {"testkey": "value"})),
            Text(I18nLocalizations.translatePlural(context, "keyPlural",
                params: {"key": "not a number"})),
            Text(I18nLocalizations.translatePlural(context, "keyPlural",
                params: {"key": "1"})),
            Text(I18nLocalizations.translatePlural(context, "keyPlural",
                params: {"key": "6"})),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
