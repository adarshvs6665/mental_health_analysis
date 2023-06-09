class Chats {
  final String chatId;
  final String chatName;
  final String chatType;
  final String recipientPhone;

  Chats({
    required this.chatId,
    required this.chatName,
    required this.chatType,
    required this.recipientPhone,
  });

  factory Chats.fromJson(Map<String, dynamic> json) {
    return Chats(
      chatId: json['chatId'],
      chatName: json['chatName'],
      chatType: json['chatType'],
      recipientPhone: json['recipientPhone'],
    );
  }
}
