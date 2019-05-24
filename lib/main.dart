import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'register.dart';
import 'profile.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: Color(0xff78909C),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Login(),
        // "/": (context) => Home(),
      },
    );
  }
}



