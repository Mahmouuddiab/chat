import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'chat_remote_ds.dart';
import '../model/chat_user_model.dart';
import '../model/message_model.dart';

@LazySingleton(as: ChatRemoteDs)
class ChatRemoteDsImpl implements ChatRemoteDs {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get all users from Firestore `users` collection
  @override
  Stream<List<ChatUserModel>> getAllUsers() {
    return _firestore.collection('users').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => ChatUserModel.fromMap(doc.data(), doc.id))
          .toList(),
    );
  }

  /// Generate a unique chat ID between two users
  @override
  String getChatId(String user1, String user2) {
    // Always order by hashCode to avoid duplicates
    return user1.hashCode <= user2.hashCode ? '$user1\_$user2' : '$user2\_$user1';
  }

  /// Get all messages from a specific chat (real-time)
  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
        .toList());
  }

  /// Send a message in a chat
  @override
  Future<void> sendMessage(String chatId, String senderId, String text) async {
    final messageId = _firestore.collection('chats').doc(chatId).collection('messages').doc().id;

    final message = MessageModel(
      id: messageId,
      senderId: senderId,
      text: text,
      timestamp: DateTime.now(),
    );

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }
}