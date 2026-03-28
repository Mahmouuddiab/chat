import 'package:flutter/material.dart';
import '../../domain/entity/chat_user.dart';

class PrivateChatHeader extends StatelessWidget implements PreferredSizeWidget {
  final ChatUser otherUser;

  const PrivateChatHeader({super.key, required this.otherUser});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      titleSpacing: 0,
      title: Row(
        children: [
          // Circle avatar with icon inside
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueGrey,
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),

          const SizedBox(width: 12),

          // Username and online status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                otherUser.username.isNotEmpty ? otherUser.username : "User",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  // Online indicator
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: otherUser.isOnline ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    otherUser.isOnline ? "Online" : "Offline",
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}