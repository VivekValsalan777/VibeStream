import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadAudio({
    required File audioFile,
    required String userId,
    required String songTitle,
  }) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_$songTitle.mp3';
      final ref = _firebaseStorage.ref().child('audio/$userId/$fileName');
      
      await ref.putFile(audioFile);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload audio: $e');
    }
  }

  Future<String> uploadImage({
    required File imageFile,
    required String userId,
    required String imageName,
  }) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_$imageName';
      final ref = _firebaseStorage.ref().child('images/$userId/$fileName');
      
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<String> uploadProfilePicture({
    required File imageFile,
    required String userId,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child('profile_pictures/$userId/profile.jpg');
      
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload profile picture: $e');
    }
  }

  Future<void> deleteFile({required String filePath}) async {
    try {
      await _firebaseStorage.ref(filePath).delete();
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  Future<void> deleteAudio({
    required String userId,
    required String audioFileName,
  }) async {
    try {
      await _firebaseStorage.ref('audio/$userId/$audioFileName').delete();
    } catch (e) {
      throw Exception('Failed to delete audio: $e');
    }
  }

  Future<void> deleteImage({
    required String userId,
    required String imageFileName,
  }) async {
    try {
      await _firebaseStorage.ref('images/$userId/$imageFileName').delete();
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}
