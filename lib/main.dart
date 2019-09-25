import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/splash.dart';
import 'pages/home.dart';
import 'pages/movie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',

      ),
      home: SplashPage(),
      routes: {
        'splash': (context) => SplashPage(),
        'home': (context) => HomePage(),
      },
    );
  }
}
