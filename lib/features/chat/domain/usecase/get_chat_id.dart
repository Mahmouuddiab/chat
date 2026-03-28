import 'package:injectable/injectable.dart';

import '../repository/chat_repository.dart';

@injectable
class GetChatId {
  final ChatRepository repository;

  GetChatId(this.repository);

  String call(String user1, String user2) {
    return repository.getChatId(user1, user2);
  }
}