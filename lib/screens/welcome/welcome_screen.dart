import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/screens/chat/chats.dart';
import 'package:mental_health_analysis/screens/settings/settings.dart';
import 'package:mental_health_analysis/screens/task/tasks.dart';
import 'package:mental_health_analysis/utils/constants.dart';
import 'package:mental_health_analysis/screens/chat/chat_component.dart';
import 'package:mental_health_analysis/screens/quiz/quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.loadIndex});

  final int loadIndex;
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late int _selectedIndex;
  late String userName;
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();

    setState(() {
      userName = userController.user.value['name'];
      _selectedIndex = widget.loadIndex;
    });
  }

  static List<Widget> _pages = [
    // HomePage(),
    // ExplorePage(),
    // ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userName = userController.user.value['name'];

    Widget bodyWidget;
    if (_selectedIndex == 0) {
      bodyWidget = Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/bg.jpeg",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 400,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpeg'),
                    fit: BoxFit.fill)),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 30,
                  width: 80,
                  height: 200,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/light-1.png'))),
                  ),
                ),
                Positioned(
                  left: 140,
                  width: 80,
                  height: 150,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/light-2.png'))),
                  ),
                ),
                Positioned(
                  right: 40,
                  top: 40,
                  width: 80,
                  height: 150,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/clock.png'))),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 6), //2/6

                  const Spacer(), // 1/6
                  //promotion card

                  Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: kDarkBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(32.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome ${userName}",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: kCyan,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Unlock insights into your mental well-being with our powerful analysis app",
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
                                  // const Text("Task",
                                  //     style: TextStyle(
                                  //         color: kCyan, fontSize: 16)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60),
                            InkWell(
                              onTap: () => Get.to(QuizScreen()),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(
                                    kDefaultPadding * 0.75), // 15
                                decoration: const BoxDecoration(
                                  gradient: kPrimaryGradient,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Text(
                                  "Lets start the analysis",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                  const Spacer(),
                  const Spacer(flex: 2), // it will take 2/6 spaces
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  //   child: Container(
                  //     height: 50,
                  //     width: double.infinity,
                  //     child: ElevatedButton(
                  //       style: ButtonStyle(
                  //         backgroundColor:
                  //             MaterialStateProperty.all<Color>(kCyan),
                  //       ),
                  //       onPressed: () {
                  //         Get.to(QuizScreen());
                  //       },
                  //       child: const Text(
                  //         'Start Analysis',
                  //         style: TextStyle(
                  //             color: kDarkBlue, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (_selectedIndex == 1) {
      bodyWidget = TaskScreen();
    } else if (_selectedIndex == 2) {
      bodyWidget = ChatListPage();
    } else {
      bodyWidget = SettingsPage();
    }

    return Scaffold(
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 44, 72, 255),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 0 ? kCyan : null),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task, color: _selectedIndex == 1 ? kCyan : null),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: _selectedIndex == 2 ? kCyan : null),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.settings, color: _selectedIndex == 3 ? kCyan : null),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
