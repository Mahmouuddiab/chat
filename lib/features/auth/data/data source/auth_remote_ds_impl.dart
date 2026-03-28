import 'package:chat/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'auth_remote_ds.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDsImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDsImpl(this._firebaseAuth,this._firestore);

  ///  Login
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user;
      if (user == null) throw Exception("User not found");

      return UserModel.fromFirebase(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  ///  Register
  @override
  Future<UserModel> register(
      String name,
      String email,
      String password,
      ) async {
    try {
      final credential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user;
      if (user == null) throw Exception("User not created");

      // Save name
      await user.updateDisplayName(name.trim());

      // Refresh user
      await user.reload();
      final updatedUser = _firebaseAuth.currentUser;

      if (updatedUser == null) throw Exception("User reload failed");

      // **Add user to Firestore `users` collection**
      await _firestore.collection('users').doc(updatedUser.uid).set({
        'username': name.trim(),
        'email': email.trim(),
        'isOnline': true, // mark online after registration
        'lastSeen': FieldValue.serverTimestamp(),
        'profileUrl': '', // optional
      });

      return UserModel.fromFirebase(updatedUser);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    }
  }

  ///  Logout
  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  ///  Get Current User
  @override
  UserModel? getCurrentUser() {
    final user = _firebaseAuth.currentUser;
    return user != null ? UserModel.fromFirebase(user) : null;
  }


  ///  Error Mapper (Clean & Scalable)
  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return "No user found for this email";
      case 'wrong-password':
        return "Incorrect password";
      case 'email-already-in-use':
        return "Email is already registered";
      case 'invalid-email':
        return "Invalid email format";
      case 'weak-password':
        return "Password must be at least 6 characters";
      case 'user-disabled':
        return "This account has been disabled";
      case 'too-many-requests':
        return "Too many attempts. Try again later";
      case 'network-request-failed':
        return "Check your internet connection";
      default:
        return e.message ?? "Authentication failed";
    }
  }
}