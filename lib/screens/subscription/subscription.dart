import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/components/custom_text.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/screens/login/login.dart';
import 'package:mental_health_analysis/utils/constants.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final userController = Get.find<UserController>();
  late final subscriptionFlag;
  late final userId;

  Future<void> subscribe() async {
    // Get.to(MainWrapper());

    const url = '$baseUrl/subscribe'; // Replace with your API endpoint

    final headers = {'Content-Type': 'application/json'};
    final payload = jsonEncode({"userId": userId});
    final response =
        await http.post(Uri.parse(url), headers: headers, body: payload);
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final userData = responseData['data'];
      // Store user info using GetX
      print(userData);
      userController.setUser(userData);
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      subscriptionFlag = userController.user.value['subscription'];
      userId = userController.user.value['userId'];
    });
    print(subscriptionFlag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription"),
        backgroundColor: const Color.fromARGB(37, 44, 73, 255),
      ),
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
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/exercise.png",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (!subscriptionFlag) ...[
                                    const Text(
                                      'Premium Plan',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: kCyan,
                                      ),
                                    ),
                                  ] else ...[
                                    const Text(
                                      'Current Plan',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: kCyan,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 30),
                                  if (!subscriptionFlag) ...[
                                    const Text(
                                      "This ia a lifetime plan which provides unlimited analysis, chat with doctors, and much more. So what are you waiting for?😍",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ] else ...[
                                    const Text(
                                      "Enjoy your lifetime plan in which you get unlimited analysis, chat with doctors, and much more.😍",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (!subscriptionFlag) ...[
                                          const Text(
                                            "Plan Price",
                                            style: TextStyle(
                                              color: kCyan,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ] else ...[
                                          const Text(
                                            "Amount Paid",
                                            style: TextStyle(
                                              color: kCyan,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                        RichText(
                                          text: const TextSpan(
                                            style: TextStyle(
                                              fontSize: 21,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "4999 ₹",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (!subscriptionFlag) ...[
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(kCyan),
                            ),
                            onPressed: () {
                              // Perform the desired action when the button is pressed
                              subscribe();
                            },
                            child: const Text(
                              'Subscribe',
                              style: TextStyle(
                                color: kDarkBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
