import 'package:chat/features/chat/domain/entity/chat_user.dart';

class ChatUserModel extends ChatUser {
  ChatUserModel({
    required super.uid,
    required super.username,
    required super.isOnline,
  });

  factory ChatUserModel.fromMap(Map<String, dynamic> map, String uid) {
    return ChatUserModel(
      uid: uid,
      username: map['username'] ?? '',
      isOnline: map['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'isOnline': isOnline,
    };
  }
}