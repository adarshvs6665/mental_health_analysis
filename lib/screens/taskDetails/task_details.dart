import 'package:flutter/material.dart';
import 'package:mental_health_analysis/components/custom_row.dart';
import 'package:mental_health_analysis/components/custom_text.dart';
import 'package:mental_health_analysis/models/Task.dart';
import 'package:mental_health_analysis/utils/constants.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  TaskDetailsScreen({required this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
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
                        child: 
                        
                        Container(
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
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kCyan),
                          ),
                          onPressed: () {
                            // Perform the desired action when the button is pressed
                            print('Complete Task button pressed');
                          },
                          child: const Text(
                            'Complete Task',
                            style: TextStyle(
                                color: kDarkBlue, fontWeight: FontWeight.bold),
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

  Widget _buildKeyValueRow(String key, String value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$key: ',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
