import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String username,
    required String email,
  }) async {
    try {
      final userModel = UserModel(
        uid: uid,
        username: username,
        email: email,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(uid)
          .set(userModel.toJson());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<UserModel?> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>, docId: doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final query = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        return UserModel.fromJson(
          query.docs.first.data() as Map<String, dynamic>,
          docId: query.docs.first.id,
        );
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch user by username: $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({
        ...user.toJson(),
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> updateUserProfilePicture(String uid, String profilePictureUrl) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'profilePicture': profilePictureUrl,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to update profile picture: $e');
    }
  }

  Future<bool> isUsernameAvailable(String username) async {
    try {
      final query = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      return query.docs.isEmpty;
    } catch (e) {
      throw Exception('Failed to check username availability: $e');
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
