import 'package:flutter/material.dart';
import '../../domain/entity/chat_user.dart';

class UserTile extends StatelessWidget {
  final ChatUser user;
  final VoidCallback onTap;

  const UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.username),
      subtitle: Text(user.isOnline ? 'Online' : 'Offline'),
      onTap: onTap,
      leading: CircleAvatar(
        child: Text(
          (user.username.isNotEmpty ? user.username[0] : "?").toUpperCase(),
        ),
      ),
    );
  }
}