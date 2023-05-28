import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/screens/welcome/welcome_screen.dart';

import 'screens/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginPage(),
      
    );
  }
}
