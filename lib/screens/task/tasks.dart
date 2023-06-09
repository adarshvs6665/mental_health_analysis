import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/models/Task.dart';
import 'package:mental_health_analysis/screens/taskDetails/task_details.dart';
import 'package:mental_health_analysis/utils/constants.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];
  String date = '';

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  List<Task> parseTasks(List<dynamic> json) {
    return json.map((task) {
      final taskId = task['taskId'] as String;
      final taskName = task['taskName'] as String;
      final taskDescription = task['taskDescription'] as String;
      final taskTime = task['taskTime'] as String;
      final status = task['status'] as String;
      final image = task['image'] as String;

      return Task(
          taskId: taskId,
          taskName: taskName,
          taskDescription: taskDescription,
          taskTime: taskTime,
          status: status,
          image: image);
    }).toList();
  }

  Future<void> fetchTasks() async {
    try {
      final userController = Get.find<UserController>();
      final userId = userController.user.value['userId'];
      final queryParameters = {'userId': userId};

      String url = '${baseUrl}/tasks';

      final response = await http
          .get(Uri.parse(url).replace(queryParameters: queryParameters));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        // print(responseData['data']);
        final data = responseData['data'];
        final tasksList = data['tasks'] as List<dynamic>;
        final date = data['assignedDate'] as String;

        final List<Task> tasks = parseTasks(tasksList);
        setState(() {
          this.tasks = tasks;
          this.date = date;
        });
      } else {
        throw Exception(
            'Failed to fetch tasks. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks for: $date'),
        toolbarHeight: 60,
        backgroundColor: const Color.fromARGB(37, 44, 73, 255),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: tasks.length > 0 ?
        
        ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Card(
              color: kDarkBlue,
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                leading: const Icon(
                  Icons.task,
                  size: 40,
                  color: kCyan,
                ),
                trailing: tasks[index].status == "PENDING"
                    ? const Icon(
                        Icons.timer,
                        color: kCyan,
                      )
                    : const Icon(
                        Icons.done,
                        color: kCyan,
                      ),
                title: Text(tasks[index].taskName),
                subtitle: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double lineHeight = 20.0; // Adjust line height as needed
                    int maxLines = (constraints.maxHeight.isFinite)
                        ? constraints.maxHeight ~/ lineHeight
                        : 3; // Default value if maxHeight is not finite

                    return Wrap(
                      children: [
                        Text(
                          tasks[index].taskDescription,
                          maxLines: maxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                ),
                onTap: () {
                  Get.to(TaskDetailsScreen(
                    task: tasks[index],
                  ));
                },
              ),
            );
          },
        ) : Text("Hii"),
      ),
    );
  }
}
