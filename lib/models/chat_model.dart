class Chat {
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTimestamp;
  final List<Map<String, dynamic>> messages;

  Chat({
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTimestamp,
    this.messages = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTimestamp': lastMessageTimestamp.toIso8601String(),
      'messages': messages,
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      participants: List<String>.from(json['participants']),
      lastMessage: json['lastMessage'],
      lastMessageTimestamp: DateTime.parse(json['lastMessageTimestamp']),
      messages: List<Map<String, dynamic>>.from(json['messages']),
    );
  }
}
