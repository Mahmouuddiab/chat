import 'package:chat/core/di/di.dart';
import 'package:chat/features/chat/presentation/widgets/private_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/chat_user.dart';
import '../../domain/entity/message.dart';
import '../cubit/private_chat_cubit.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class PrivateChatScreen extends StatelessWidget {
  final String chatId;
  final String currentUserId;
  final ChatUser otherUser;

  const PrivateChatScreen({
    super.key,
    required this.chatId,
    required this.currentUserId,
    required this.otherUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrivateChatCubit>(
      create: (_) => getIt<PrivateChatCubit>()..fetchMessages(chatId),
      child: Scaffold(
        appBar: PrivateChatHeader(otherUser: otherUser),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<PrivateChatCubit, List<Message>>(
                builder: (context, messages) {
                  if (messages.isEmpty) {
                    return const Center(child: Text("No messages yet"));
                  }

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[messages.length - 1 - index];
                      final isMe = msg.senderId == currentUserId;
                      return MessageBubble(message: msg, isMe: isMe);
                    },
                  );
                },
              ),
            ),

            // Use the new MessageInput widget
            MessageInput(chatId: chatId, currentUserId: currentUserId),
          ],
        ),
      ),
    );
  }
}