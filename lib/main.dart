import 'package:app_emblem/Screens/Home/home_screens.dart';
import 'package:app_emblem/Screens/Offer/offer_screen.dart';
import 'package:app_emblem/Screens/global.dart';
import 'package:flutter/material.dart';
import 'package:app_emblem/constants.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emblem',
      theme: ThemeData(
        backgroundColor: kBackgroundColor,
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kAppPrimaryColor,
        secondaryHeaderColor: kAppSecondaryColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: kBackgroundColor,
        ),
        textTheme: TextTheme(bodyText2: TextStyle(color: kTextColorOnLight)),
      ),
      home: GlobalPage(),
      //home: HomeScreen(title: "Bienvenue sur la page d'accueil Emblem"),
    );
  }
}


