import 'package:chat/core/di/di.dart';
import 'package:chat/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chat/features/auth/presentation/cubit/auth_state.dart';
import 'package:chat/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = getIt<AuthCubit>();
    authCubit.loadCurrentUser();
  }

  @override
  void dispose() {
    authCubit.close(); // ✅ IMPORTANT
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            /// ✅ Navigate after logout
            if (state is AuthInitial) {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen(),));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is AuthSuccess) {
                  final user = state.user;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// 👤 Avatar
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person, size: 40),
                      ),

                      const SizedBox(height: 20),

                      /// 👋 Name
                      Text(
                        "Hello, ${user.name}".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// 📧 Email
                      Text(
                        "Email: ${user.email}",
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 30),

                      /// 🔴 Logout Button
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _showLogoutDialog(context, () {
                              authCubit.logout();
                              Navigator.pop(context);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedSuperellipseBorder()
                          ),
                          child: const Text("Logout",style: TextStyle(color: Colors.red),),
                        ),
                      ),
                    ],
                  );
                }

                if (state is AuthError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                return const Center(
                  child: Text('No user logged in'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// 🔐 Logout Dialog
void _showLogoutDialog(BuildContext context, VoidCallback? onPressed) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            "Logout",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}