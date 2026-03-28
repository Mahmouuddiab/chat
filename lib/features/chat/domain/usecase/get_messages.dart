import 'package:injectable/injectable.dart';
import '../repository/chat_repository.dart';
import '../entity/message.dart';

@injectable
class GetMessages {
  final ChatRepository repository;

  GetMessages(this.repository);

  Stream<List<Message>> call(String chatId) {
    return repository.getMessages(chatId);
  }
}