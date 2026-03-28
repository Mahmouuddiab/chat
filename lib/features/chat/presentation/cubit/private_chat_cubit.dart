import 'dart:async';
import 'package:chat/features/chat/domain/entity/message.dart';
import 'package:chat/features/chat/domain/usecase/get_messages.dart';
import 'package:chat/features/chat/domain/usecase/send_messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PrivateChatCubit extends Cubit<List<Message>> {
  final GetMessages getMessagesUseCase;
  final SendMessage sendMessageUseCase;
  StreamSubscription? _subscription;

  PrivateChatCubit({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
  }) : super([]);

  void fetchMessages(String chatId) {
    _subscription = getMessagesUseCase(chatId).listen((messages) => emit(messages));
  }

  void sendMessage(String chatId, String senderId, String text) {
    sendMessageUseCase(chatId, senderId, text);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}