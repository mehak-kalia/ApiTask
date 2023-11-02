import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapitask/app/providers/NewsProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../ui/screens/NewsScreen.dart';


class MyApp extends StatefulWidget {

  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();




}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''),
        Locale('hi', '')
      ],
      debugShowCheckedModeBanner: false,
      theme: Provider.of<NewsProvider>(context).currentTheme, // Set the theme based on provider

      home: NewsScreen(),
    );
  }

  void setLocale(Locale newLocale) {}

}

