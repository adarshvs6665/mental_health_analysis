import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mental_health_analysis/screens/AccessFailed/AccessFailed.dart';
import 'package:mental_health_analysis/screens/login/login.dart';
import 'package:mental_health_analysis/screens/welcome/welcome_screen.dart';
import 'components/body.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final box = GetStorage();
  late DateTime lastAccessDate;
  late Widget bodyWidget;

  @override
  void initState() {
    super.initState();
    lastAccessDate = box.read('lastAccessDate') ?? DateTime(2000);
    final currentDate = DateTime.now();
    if (currentDate.difference(lastAccessDate).inDays == 0) {
      setState(() {
        // bodyWidget = AccessFailed();
        bodyWidget = Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: const Body(),
        );
      });
    } else {
      setState(() {
        bodyWidget = Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: const Body(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return bodyWidget;
  }
}
