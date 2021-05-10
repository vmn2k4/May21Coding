import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themelocalization/pages/camera/camera.dart';
import 'package:themelocalization/pages/find/find.dart';
import 'package:themelocalization/pages/newsFeed/newsFeed.dart';

import 'shared/themes/appTheme.dart';
import 'shared/themes/themeChangeNotifier.dart';

import 'package:flutter_localizations/flutter_localizations.dart'; // important
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeChangeNotifier>(
    create: (context) => ThemeChangeNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<ThemeChangeNotifier>(
        builder: (context, themeChangeNotifier, child) {
      return MaterialApp(
          // Localization Support
          localizationsDelegates:
              AppLocalizations.localizationsDelegates, // important
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale.fromSubtags(
              languageCode:
                  'en'), // Use this to update the language, if you don't have this system language will be selected
          home: HomePage(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeChangeNotifier.isDarkModeOn
              ? ThemeMode.dark
              : ThemeMode.light,
          routes: {
            Camera.routeName: (ctx) => Camera(),
            NewsFeed.routeName: (ctx) => NewsFeed(),
            Find.routeName: (ctx) => Find(),
          });
    });
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "App Platform Template",
          ),
          actions: <Widget>[
            Switch(
              value: Provider.of<ThemeChangeNotifier>(context).isDarkModeOn,
              onChanged: (boolVal) {
                Provider.of<ThemeChangeNotifier>(context, listen: false)
                    .updateTheme(boolVal);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Text(AppLocalizations.of(context).chat),
            Text(AppLocalizations.of(context).story),
            Text(AppLocalizations.of(context).capture),
            Text(AppLocalizations.of(context).test),
            Text(AppLocalizations.of(context).button),
          ],
        ) //Text(AppLocalizations.of(context).helloWorld),
        );
  }
}
