import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health_analysis/models/Chats.dart';
import 'package:mental_health_analysis/screens/chat/chat_component.dart';
import 'dart:convert';
import '../../utils/constants.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<dynamic> chatList = [];

  @override
  void initState() {
    super.initState();
    fetchChatList();
  }

  Future<void> fetchChatList() async {
    const url = '$baseUrl/chats';

    final headers = {'Content-Type': 'application/json'};
    final queryParameters = {
      'userId': "c6470a41-7a96-454a-953f-118d031ee767",
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
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/icons/bg.jpeg'),
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

            return Card(
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
                      chatId: chatId, chatName: chatName, chatType: chatType));
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Perform the desired action when the button is pressed
            print('Floating Action Button pressed');
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
