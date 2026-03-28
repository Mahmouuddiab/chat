import 'dart:async';
import 'package:chat/features/chat/domain/usecase/get_all_users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entity/chat_user.dart';

@injectable
class ChatCubit extends Cubit<List<ChatUser>> {
  final GetAllUsers getAllUsersUseCase;
  StreamSubscription? _subscription;

  ChatCubit({required this.getAllUsersUseCase}) : super([]);

  void fetchUsers() {
    _subscription = getAllUsersUseCase()
        .listen((users) => emit(users));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}