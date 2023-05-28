import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/screens/welcome/welcome_screen.dart';

import 'screens/login/login.dart';

void main() async {
  await GetStorage.init();
  Get.put<UserController>(UserController());

  final userController = Get.find<UserController>();
  final userId = userController.user.value['userId'];
  Widget initialPage;

  if (userId != null) {
    initialPage = WelcomeScreen();
  } else {
    initialPage = LoginPage();
  }

  runApp(
    GetMaterialApp(
      title: 'Mental Health Analysis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: initialPage,
      
    ),
  );
}
