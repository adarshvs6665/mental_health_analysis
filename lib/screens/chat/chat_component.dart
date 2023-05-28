import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/controllers/userController.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../utils/constants.dart';

class ChatComponent extends StatefulWidget {
  final String chatName;
  final String chatId;
  final String chatType;

  const ChatComponent(
      {Key? key,
      required this.chatName,
      required this.chatId,
      required this.chatType})
      : super(key: key);

  @override
  _ChatComponentState createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  final userController = Get.find<UserController>();
  String userIdMine = '';

  List<Map<String, String>> chatMessages = [];

  IO.Socket? socket;
  TextEditingController messageController = TextEditingController();

  void sendGroupMessage(userId, name) {
    String message = messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        // chatMessages.add({"userId":userId,"message": message, "name": name});
        messageController.clear();
      });

      // Emit the message to the server
      socket?.emit("sendGroupMessage", {
        "chatId": widget.chatId,
        "userId": userId,
        "message": message,
        "name": name,
      });
    }
  }

  void sendDoctorMessage(userId, name) {
    String message = messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        // chatMessages.add({"userId":userId,"message": message, "name": name});
        messageController.clear();
      });

      // Emit the message to the server
      socket?.emit("sendDoctorMessage", {
        "chatId": widget.chatId,
        "userId": userId,
        "message": message,
        "name": name,
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final userId = userController.user.value['userId'];
    setState(() {
      userIdMine = userId;
      chatMessages = [
        {
          "userId": userIdMine,
          "message": "Hello, how are you?",
          "name": "Adarsh"
        },
        {
          "userId": "7a96-454a-953f-c6470a41-118d031ee767",
          "message": "Hi! I'm doing well, thank you.",
          "name": "Adwait"
        },
        {
          "userId": "118d031ee767-c6470a41-7a96-454a-953f",
          "message": "How about you?",
          "name": "Adwait"
        },
        {"userId": userIdMine, "message": "I'm good too!", "name": "Adarsh"},
      ];
    });
    if (widget.chatType == 'group') {
      connectToGroupSocket();
    } else {
      connectToDoctorSocket();
    }
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }

  Future<void> connectToGroupSocket() async {
    // Replace the URL with your Socket.IO server URL
    socket = IO.io('${socketURL}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket!.onConnect((_) {
      print('Connected to Socket.IO server');
      // Emit an event or perform any necessary actions upon connection
      // For example, you can emit an event to join the group chat room
      socket!.emit('joinGroupChat', {'chatId': widget.chatId});
    });

    socket!.onDisconnect((_) => print('Disconnected from Socket.IO server'));

    // Listen for incoming chat messages
    socket!.on('newGroupMessage', (data) {
      // Handle the incoming message data and update the chatMessages list
      setState(() {
        chatMessages.add({
          "message": data["message"],
          "name": data["name"],
          "userId": data["userId"]
        });
      });
    });
  }

  Future<void> connectToDoctorSocket() async {
    // Replace the URL with your Socket.IO server URL
    socket = IO.io('${socketURL}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket!.onConnect((_) {
      print('Connected to Socket.IO server');
      // Emit an event or perform any necessary actions upon connection
      // For example, you can emit an event to join the group chat room
      socket!.emit('joinDoctorChat', {'chatId': widget.chatId});
    });

    socket!.onDisconnect((_) => print('Disconnected from Socket.IO server'));

    // Listen for incoming chat messages
    socket!.on('newDoctorMessage', (data) {
      // Handle the incoming message data and update the chatMessages list
      setState(() {
        chatMessages.add({
          "message": data["message"],
          "name": data["name"],
          "userId": data["userId"]
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String chatName = widget.chatName;
    return Scaffold(
      appBar: AppBar(
        title: Text(chatName),
        backgroundColor: const Color.fromARGB(37, 44, 73, 255),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final message = chatMessages[index];
                  final isUserMessage = message['userId'] == userIdMine;
                  final messageContent = message['message'];

                  if (!isUserMessage) {
                    final name = message['name'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 4.0),
                            const Icon(
                              Icons.account_circle,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              name ?? '',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.75,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              messageContent!,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 6, 57, 112),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'You',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4.0),
                              Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4.0),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.fromLTRB(
                                    8.0, 4.0, 8.0, 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 4.0),
                                    Text(
                                      messageContent!,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]);
                  }
                },
              ),
            ),
            Container(
              color: const Color.fromARGB(37, 44, 73, 255),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your message',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () => {
                      widget.chatType == 'group'
                          ? sendGroupMessage(userIdMine, "Abhishek")
                          : sendDoctorMessage(userIdMine, "Adarsh")
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
