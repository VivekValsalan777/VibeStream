import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'dart:io';

class StorageProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String? _error;

  bool get isUploading => _isUploading;
  double get uploadProgress => _uploadProgress;
  String? get error => _error;

  Future<String?> uploadAudio({
    required File audioFile,
    required String userId,
    required String songTitle,
  }) async {
    _isUploading = true;
    _error = null;
    _uploadProgress = 0.0;
    notifyListeners();

    try {
      final url = await _storageService.uploadAudio(
        audioFile: audioFile,
        userId: userId,
        songTitle: songTitle,
      );
      _uploadProgress = 1.0;
      _isUploading = false;
      notifyListeners();
      return url;
    } catch (e) {
      _error = e.toString();
      _isUploading = false;
      notifyListeners();
      return null;
    }
  }

  Future<String?> uploadImage({
    required File imageFile,
    required String userId,
    required String imageName,
  }) async {
    _isUploading = true;
    _error = null;
    _uploadProgress = 0.0;
    notifyListeners();

    try {
      final url = await _storageService.uploadImage(
        imageFile: imageFile,
        userId: userId,
        imageName: imageName,
      );
      _uploadProgress = 1.0;
      _isUploading = false;
      notifyListeners();
      return url;
    } catch (e) {
      _error = e.toString();
      _isUploading = false;
      notifyListeners();
      return null;
    }
  }

  Future<String?> uploadProfilePicture({
    required File imageFile,
    required String userId,
  }) async {
    _isUploading = true;
    _error = null;
    _uploadProgress = 0.0;
    notifyListeners();

    try {
      final url = await _storageService.uploadProfilePicture(
        imageFile: imageFile,
        userId: userId,
      );
      _uploadProgress = 1.0;
      _isUploading = false;
      notifyListeners();
      return url;
    } catch (e) {
      _error = e.toString();
      _isUploading = false;
      notifyListeners();
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
