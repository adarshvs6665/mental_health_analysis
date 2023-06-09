import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/components/custom_text.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/models/Task.dart';
import 'package:mental_health_analysis/screens/welcome/welcome_screen.dart';
import 'package:mental_health_analysis/utils/constants.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  TaskDetailsScreen({required this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final userController = Get.find<UserController>();
  late final userId;

  Future<void> completeTask(taskId) async {
    // Get.to(MainWrapper());

    const url = '$baseUrl/complete-task'; // Replace with your API endpoint

    final headers = {'Content-Type': 'application/json'};
    final payload = jsonEncode({"userId": userId, "taskId": taskId});
    final response =
        await http.post(Uri.parse(url), headers: headers, body: payload);
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Get.to(WelcomeScreen(loadIndex: 1));
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      userId = userController.user.value['userId'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.taskName),
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
                  widget.task.image,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kCyan,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    widget.task.taskDescription,
                                    style: const TextStyle(
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
                                        const Text("Task",
                                            style: TextStyle(
                                                color: kCyan, fontSize: 16)),
                                        CustomText(
                                          inputText: widget.task.taskName,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Status",
                                            style: TextStyle(
                                                color: kCyan, fontSize: 16)),
                                        CustomText(
                                          inputText: widget.task.status,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Duration",
                                            style: TextStyle(
                                                color: kCyan, fontSize: 16)),
                                        CustomText(
                                          inputText: widget.task.taskTime,
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
                            backgroundColor: widget.task.status == 'PENDING'
                                ? MaterialStateProperty.all<Color>(kCyan)
                                : MaterialStateProperty.all<Color>(kDarkBlue),
                          ),
                          onPressed: () {
                            if (widget.task.status == 'PENDING') {
                              completeTask(widget.task.taskId);
                            }
                          },
                          child: widget.task.status == 'PENDING'
                              ? const Text(
                                  'Complete Task',
                                  style: TextStyle(
                                      color: kDarkBlue,
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text(
                                  'Completed',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
}
