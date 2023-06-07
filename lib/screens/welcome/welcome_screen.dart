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
    Widget bodyWidget;
    if (_selectedIndex == 0) {
      bodyWidget = Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset(
              "assets/images/bg.svg",
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2), //2/6
                  Text(
                    "Welcome ${userName},",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text("Enter your id here:"),
                  Spacer(), // 1/6
                  const TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  Spacer(), // 1/6
                  InkWell(
                    onTap: () => Get.to(QuizScreen()),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding:
                          const EdgeInsets.all(kDefaultPadding * 0.75), // 15
                      decoration: const BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
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
                  const Spacer(flex: 2), // it will take 2/6 spaces
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
        backgroundColor: Color.fromARGB(255, 44, 72, 255),
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
