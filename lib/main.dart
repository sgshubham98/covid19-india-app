import 'package:covid19_app/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/screens/splash_screen.dart';
import 'package:covid19_app/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Covid 19 India",
      theme: ThemeData.light(),
      initialRoute: '/SplashScreen',
      routes: <String, WidgetBuilder>{
        '/SplashScreen': (BuildContext context) => SplashScreen(),
        '/LoadingScreen': (context) => LoadingScreen(),
        '/HomeScreen': (BuildContext context) => HomeScreen(),
      },
    );
  }
}
