import 'package:injectable/injectable.dart';

import '../repository/chat_repository.dart';
import '../entity/chat_user.dart';

@injectable
class GetAllUsers {
  final ChatRepository repository;

  GetAllUsers(this.repository);

  Stream<List<ChatUser>> call() {
    return repository.getAllUsers();
  }
}