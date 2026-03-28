import 'package:chat/features/chat/data/model/chat_user_model.dart';
import 'package:chat/features/chat/data/model/message_model.dart';

abstract class ChatRemoteDs {
  Stream<List<ChatUserModel>> getAllUsers();
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<void> sendMessage(String chatId, String senderId, String text);
  String getChatId(String user1, String user2);
}