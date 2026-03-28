import 'package:chat/core/di/di.dart';
import 'package:chat/features/chat/domain/usecase/get_chat_id.dart';
import 'package:chat/features/chat/presentation/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/chat_user.dart';
import '../cubit/chat_cubit.dart';
import 'private_chat_screen.dart';

class ChatScreen extends StatelessWidget {
  final String currentUserId;
  final GetChatId getChatIdUseCase;

   ChatScreen({
    super.key,
    required this.currentUserId,
    required this.getChatIdUseCase,
  });

   var chatCubit = getIt<ChatCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => chatCubit..fetchUsers(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Users')),
        body: BlocBuilder<ChatCubit, List<ChatUser>>(
          builder: (context, users) {
            if (users.isEmpty) return const Center(child: CircularProgressIndicator());

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                if (user.uid == currentUserId) return Container();

                return UserTile(
                  user: user,
                  onTap: () {
                    final chatId = getChatIdUseCase(currentUserId, user.uid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PrivateChatScreen(
                          chatId: chatId,
                          currentUserId: currentUserId,
                          otherUser: user,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}