import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/controllers/questionController.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/screens/welcome/welcome_screen.dart';
import 'package:mental_health_analysis/utils/constants.dart';
import 'package:flutter_svg/svg.dart';

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

          print(payload);
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
                                          15) ...[
                                        const Text(
                                          "You seem to be having a really bad day. It's a part of life. This too shall pass.  Don't be afraid to reachout. You can contact the psychologists available in the app for guidance.",
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
        )

        // Scaffold(
        //     body: Stack(
        //   fit: StackFit.expand,
        //   children: [
        //     Container(
        //       width: double.infinity,
        //       height: double.infinity,
        //       child: SvgPicture.asset(
        //         "assets/images/bg.svg",
        //         fit: BoxFit.fill,
        //       ),
        //     ),
        //     Container(
        //       height: 400,
        //       decoration: const BoxDecoration(
        //           image: DecorationImage(
        //               image: AssetImage('assets/images/bg.jpeg'),
        //               fit: BoxFit.fill)),
        //       child: Stack(
        //         children: <Widget>[
        //           Positioned(
        //             left: 30,
        //             width: 80,
        //             height: 200,
        //             child: Container(
        //               decoration: const BoxDecoration(
        //                   image: DecorationImage(
        //                       image: AssetImage('assets/images/light-1.png'))),
        //             ),
        //           ),
        //           Positioned(
        //             left: 140,
        //             width: 80,
        //             height: 150,
        //             child: Container(
        //               decoration: const BoxDecoration(
        //                   image: DecorationImage(
        //                       image: AssetImage('assets/images/light-2.png'))),
        //             ),
        //           ),
        //           Positioned(
        //             right: 40,
        //             top: 40,
        //             width: 80,
        //             height: 150,
        //             child: Container(
        //               decoration: const BoxDecoration(
        //                   image: DecorationImage(
        //                       image: AssetImage('assets/images/clock.png'))),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     SafeArea(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(
        //             horizontal: kDefaultPadding, vertical: kDefaultPadding),
        //         child: Container(
        //             height: 350,
        //             decoration: BoxDecoration(
        //               color: kDarkBlue,
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //             padding: const EdgeInsets.all(32.0),
        //             child: Padding(
        //               padding: const EdgeInsets.only(top: 12.0),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     "Mental Score  :  ${questionController.totalScore}",
        //                     style: TextStyle(
        //                       fontSize: 30,
        //                       fontWeight: FontWeight.bold,
        //                       color: kCyan,
        //                     ),
        //                   ),
        //                   const SizedBox(height: 10),
        //                   Text(
        //                     "You seem to be having a really bad day. It's a part of life. This too shall pass.  Don't be afraid to reachout. You can contact the psychologists available in the app for guidance.",
        //                     style: const TextStyle(
        //                       fontSize: 18,
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                   const SizedBox(height: 30),
        //                   Padding(
        //                     padding: const EdgeInsets.only(top: 12.0),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         // const Text("Task",
        //                         //     style: TextStyle(
        //                         //         color: kCyan, fontSize: 16)),
        //                       ],
        //                     ),
        //                   ),
        //                   const SizedBox(height: 60),
        //                   InkWell(
        //                     // onTap: () => Get.to(QuizScreen()),
        //                     child: Container(
        //                       width: double.infinity,
        //                       alignment: Alignment.center,
        //                       padding: const EdgeInsets.all(
        //                           kDefaultPadding * 0.75), // 15
        //                       decoration: const BoxDecoration(
        //                         gradient: kPrimaryGradient,
        //                         borderRadius:
        //                             BorderRadius.all(Radius.circular(12)),
        //                       ),
        //                       child: Text(
        //                         "Go to Home Page",
        //                         style: Theme.of(context)
        //                             .textTheme
        //                             .labelLarge
        //                             ?.copyWith(color: Colors.black),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )),
        //       ),
        //     ),
        //   ],
        // )

        //     // Stack(
        //     //   fit: StackFit.expand,
        //     //   children: [
        //     //     SvgPicture.asset("assets/images/bg.svg", fit: BoxFit.fill),
        //     //     Column(
        //     //       children: [
        //     //         Spacer(flex: 3),
        //     //         Text(
        //     //           "Score",
        //     //           style: Theme.of(context)
        //     //               .textTheme
        //     //               .headline3
        //     //               ?.copyWith(color: kSecondaryColor),
        //     //         ),
        //     //         Spacer(),
        //     //         Text(
        //     //           "${questionController.totalScore}",
        //     //           style: Theme.of(context)
        //     //               .textTheme
        //     //               .headline4
        //     //               ?.copyWith(color: kSecondaryColor),
        //     //         ),
        //     //         Spacer(flex: 3),
        //     //       ],
        //     //     )
        //     //   ],
        //     // ),
        //     )

        );
  }
}
