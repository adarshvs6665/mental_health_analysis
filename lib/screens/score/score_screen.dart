import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/controllers/questionController.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/screens/welcome/welcome_screen.dart';
import 'package:mental_health_analysis/utils/constants.dart';

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  QuestionController2 questionController = Get.put(QuestionController2());
  final userController = Get.find<UserController>();
  late final userId;

  Future<void> evaluateAnalysis() async {
    const url = '$baseUrl/evaluate-analysis'; // Replace with your API endpoint

    try {
      final headers = {'Content-Type': 'application/json'};
      final payload = jsonEncode(
          {"userId": userId, "score": questionController.totalScore});
      final response =
          await http.post(Uri.parse(url), headers: headers, body: payload);
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final userData = responseData['data'];
        userController.setUser(userData);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      userId = userController.user.value['userId'];
    });
    evaluateAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.off(const WelcomeScreen(loadIndex: 0));
          return true; // Return true to allow the app to exit if there is no previous route
        },
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/meditation.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Spacer(),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: kDarkBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(32.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mental Score  :  ${questionController.totalScore}",
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: kCyan,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      if (questionController.totalScore <=
                                          81) ...[
                                        const Text(
                                          "You seem to be having a really bad day. It's a part of life. This too shall pass.  Don't be afraid to reachout. You can contact the psychologists available in the app for guidance after subscription.",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ] else ...[
                                        const Text(
                                          "You seem to be have your emotions under control.",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 30),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(kCyan),
                                          ),
                                          onPressed: () {
                                            Get.off(
                                                WelcomeScreen(loadIndex: 0));
                                          },
                                          child: const Text(
                                            'Go to Home Page',
                                            style: TextStyle(
                                                color: kDarkBlue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          )),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
