import 'package:chat/features/chat/data/data%20source/chat_remote_ds.dart';
import 'package:chat/features/chat/domain/entity/chat_user.dart';
import 'package:chat/features/chat/domain/entity/message.dart';
import 'package:chat/features/chat/domain/repository/chat_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDs _remoteDs;

  ChatRepositoryImpl(this._remoteDs);

  /// Fetch all users as ChatUser entities
  @override
  Stream<List<ChatUser>> getAllUsers() {
    return _remoteDs.getAllUsers().map(
          (list) => list
          .map((userModel) => ChatUser(
        uid: userModel.uid,
        username: userModel.username,
        isOnline: userModel.isOnline,
      ))
          .toList(),
    );
  }

  /// Generate unique chat ID
  @override
  String getChatId(String user1, String user2) {
    return _remoteDs.getChatId(user1, user2);
  }

  /// Fetch all messages as Message entities
  @override
  Stream<List<Message>> getMessages(String chatId) {
    return _remoteDs.getMessages(chatId).map(
          (list) => list
          .map((msgModel) => Message(
        id: msgModel.id,
        senderId: msgModel.senderId,
        text: msgModel.text,
        timestamp: msgModel.timestamp,
      ))
          .toList(),
    );
  }

  /// Send message via remote DS
  @override
  Future<void> sendMessage(String chatId, String senderId, String text) {
    return _remoteDs.sendMessage(chatId, senderId, text);
  }
}