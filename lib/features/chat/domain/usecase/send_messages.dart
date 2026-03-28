import 'package:injectable/injectable.dart';
import '../repository/chat_repository.dart';

@injectable
class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<void> call(String chatId, String senderId, String text) {
    return repository.sendMessage(chatId, senderId, text);
  }
}