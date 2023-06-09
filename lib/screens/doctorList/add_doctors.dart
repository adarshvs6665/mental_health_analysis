import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/models/Doctor.dart';
import 'package:mental_health_analysis/screens/welcome/welcome_screen.dart';
import 'package:mental_health_analysis/utils/constants.dart';
import 'package:http/http.dart' as http;

class DoctorListPage extends StatefulWidget {
  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  List<dynamic> doctorsList = [];

  late String userIdMine;
  final userController = Get.find<UserController>();

  Set<String> selectedDoctors = Set<String>();

  Future<void> fetchChatList() async {
    const url = '$baseUrl/doctors';

    final headers = {'Content-Type': 'application/json'};
    final queryParameters = {
      'userId': userIdMine,
    };

    final response = await http.get(
        Uri.parse(url).replace(queryParameters: queryParameters),
        headers: headers);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> chatData = responseData['data'];
      final List<Doctor> doctors =
          chatData.map((json) => Doctor.fromJson(json)).toList();

      setState(() {
        doctorsList = responseData['data'];
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> addDoctorToChat() async {
    final List doctorIdsList = selectedDoctors.toList();
    const url = '$baseUrl/add-doctors'; // Replace with your API endpoint

    final headers = {'Content-Type': 'application/json'};
    final payload = jsonEncode({
      'userId': userIdMine,
      'doctors': doctorIdsList,
    });
    final response =
        await http.post(Uri.parse(url), headers: headers, body: payload);
    // final userController = Get.find<UserController>();
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Get.off(WelcomeScreen(loadIndex: 2));
    } else {
      // Handle API error
      final responseMessage = responseData['message'];
      Fluttertoast.showToast(
          msg: responseMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 6.0);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      userIdMine = userController.user.value['userId'];
    });
    fetchChatList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(WelcomeScreen(loadIndex: 2));
        return true; // Return true to allow the app to exit if there is no previous route
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Doctors'),
          backgroundColor:
              const Color.fromARGB(37, 44, 73, 255), // Set app bar color
          actions: [
            if (selectedDoctors.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextButton(
                  onPressed: () {
                    addDoctorToChat();
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: kCyan,
                      primary: kDarkBlue,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                  child: const Text("Add to chat"),
                ),
              ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: doctorsList.length > 0
              ? ListView.builder(
                  itemCount: doctorsList.length,
                  itemBuilder: (context, index) {
                    final name = doctorsList[index]['name'];
                    final id = doctorsList[index]['doctorId'];
                    final isChecked = selectedDoctors.contains(id);
                    return Card(
                        color: kDarkBlue,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 7),
                          leading: Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                if (isChecked) {
                                  selectedDoctors.remove(id);
                                } else {
                                  selectedDoctors.add(id!);
                                }
                              });
                            },
                          ),
                          title: Text(name!),
                          onTap: () {
                            setState(() {
                              if (isChecked) {
                                selectedDoctors.remove(id!);
                              } else {
                                selectedDoctors.add(id!);
                              }
                            });
                          },
                        ));
                  },
                )
              : Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.done_all_outlined,
                        color: kCyan,
                        size: 80.0,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'All doctors added!',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
