import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/screens/login/login.dart';
import 'package:mental_health_analysis/screens/subscription/subscription.dart';
import 'package:mental_health_analysis/utils/constants.dart';

class AccessFailed extends StatefulWidget {
  @override
  _AccessFailedState createState() => _AccessFailedState();
}

class _AccessFailedState extends State<AccessFailed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.alarm_outlined,
                  color: kCyan,
                  size: 80.0,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Come back tomorrow',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ))));
  }
}
