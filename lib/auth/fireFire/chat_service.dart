import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a chat message
  Future<void> addChatMessage(ChatModel chat) async {
    await _firestore
        .collection('chats')
        .add(chat.toJson());
  }

  // Retrieve chat messages between two users
  Future<List<ChatModel>> getChatMessages(String userId, String otherUserId) async {
    final query = await _firestore
        .collection('chats')
        .where('senderId', isEqualTo: userId)
        .where('receiverId', isEqualTo: otherUserId)
        .get();

    return query.docs.map((doc) => ChatModel.fromJson(doc.data())).toList();
  }
}
