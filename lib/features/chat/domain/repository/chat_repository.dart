import 'package:chat/features/chat/domain/entity/chat_user.dart';
import 'package:chat/features/chat/domain/entity/message.dart';

abstract class ChatRepository {
  Stream<List<ChatUser>> getAllUsers();
  Stream<List<Message>> getMessages(String chatId);
  Future<void> sendMessage(String chatId, String senderId, String text);
  String getChatId(String user1, String user2);
}