import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:mental_health_analysis/models/Chats.dart';
import 'package:mental_health_analysis/screens/chat/chat_component.dart';
import 'package:mental_health_analysis/screens/doctorList/add_doctors.dart';
import 'dart:convert';
import '../../utils/constants.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<dynamic> chatList = [];
  final userController = Get.find<UserController>();
  late String userIdMine;
  late bool subscriptionFlag;

  @override
  void initState() {
    super.initState();
    setState(() {
      subscriptionFlag = userController.user.value['subscription'];
      userIdMine = userController.user.value['userId'];
    });
    fetchChatList();
  }

  Future<void> fetchChatList() async {
    const url = '$baseUrl/chats';

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
      final List<Chats> chats =
          chatData.map((json) => Chats.fromJson(json)).toList();

      setState(() {
        chatList = responseData['data'];
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
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
          child: ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              final chat = chatList[index];
              final chatName = chat['chatName'];
              final chatType = chat['chatType'];
              final chatId = chat['chatId'];
              final recipientPhone = chat['recipientPhone'];

              return Card(
                color: kDarkBlue,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                child: ListTile(
                  leading: chatType == 'group'
                      ? const Icon(
                          Icons.group_rounded,
                          size: 40,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.account_circle,
                          size: 40,
                          color: Colors.blue,
                        ),
                  title: Text(chatName),
                  subtitle: Text(chatType),
                  onTap: () {
                    // Handle chat item tap event
                    // Navigate to chat details page or perform any desired action
                    Get.to(ChatComponent(
                        chatId: chatId,
                        chatName: chatName,
                        chatType: chatType,
                        recipientPhone: recipientPhone));
                  },
                ),
              );
            },
          ),
        ),
        floatingActionButton: subscriptionFlag
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(DoctorListPage());
                },
                child: Icon(Icons.add),
              )
            : null);
  }
}
