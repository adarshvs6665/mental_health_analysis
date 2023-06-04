import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/components/custom_text.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/screens/login/login.dart';
import 'package:mental_health_analysis/utils/constants.dart';

class SubscriptionPage extends StatelessWidget {
  final userController = Get.find<UserController>();

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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Premium Plan',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: kCyan,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    "This ia a lifetime plan which provides unlimited analysis, chat with doctors, and much more. So what are you waiting for?😍",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Plan Price",
                                            style: TextStyle(
                                                color: kCyan, fontSize: 20)),
                                        RichText(
                                          text: TextSpan(
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
                            )),
                      )),

                      const SizedBox(height: 16),
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
                            print('Subscribe');
                          },
                          child: const Text(
                            'Subscribe',
                            style: TextStyle(
                                color: kDarkBlue, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
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

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Subscription'),
  //     ),
  //     body: Container(
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage('assets/images/bg.jpeg'),
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
  //               child: Align(
  //                 alignment: Alignment.center,
  //                 child: Column(

  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'Premium Plan',
  //                       style: TextStyle(
  //                         fontSize: 30,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     SizedBox(height: 16),
  //                     Text(
  //                       'Click here to purchase a lifetime plan which provides unlimited analysis, chat with doctors, and much more.',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         color: Colors.white,
  //                       ),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                     SizedBox(height: 32),
  // Text(
  //   'Price: ₹4999',
  //   style: TextStyle(
  //     fontSize: 18,
  //     fontWeight: FontWeight.bold,
  //     color: Colors.white,
  //   ),
  // ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Container(
  //               height: 50,
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 style: ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.all<Color>(kCyan),
  //                 ),
  //                 onPressed: () {},
  //                 child: const Text(
  //                   'Subscribe',
  //                   style: TextStyle(
  //                     color: kDarkBlue,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
