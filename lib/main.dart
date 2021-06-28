import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/Screens/OnBoarding/OnBoarding.dart';
import 'package:social/Screens/home/home_Screen.dart';
import 'package:social/network/local/CacheHelper.dart';

import 'helper/MyBlocObserver.dart';

var token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await Cachehelper.init();
  Widget widget;
  token = Cachehelper.getDate(key: 'token');
  if (token != null) {
    widget = HomeScreen();
  } else {
    widget = OnBoarding();
  }
  runApp(myapp(widget));
}

class myapp extends StatelessWidget {
  final Widget widget;

  myapp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecommerce App",
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF18191a),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
        bottomAppBarColor: Color(0xFF18191a),
        appBarTheme: AppBarTheme(
          color: Color(0xFF18191a),
          elevation: 0,
        ),
        dividerColor: Colors.grey,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "FredokaOne",
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "FredokaOne",
          ),
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF18191a),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
        bottomAppBarColor: Color(0xFF18191a),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF18191a),
          elevation: 0,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "FredokaOne",
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: "FredokaOne",
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: widget,
    );
  }
}
