import 'dart:io';
import '../constants/app_constants.dart';

class FileUtils {
  static bool isValidAudioFile(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    return AppConstants.supportedAudioFormats.contains(extension);
  }

  static bool isValidImageFile(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    return AppConstants.supportedImageFormats.contains(extension);
  }

  static bool isValidFileSize(File file, int maxSizeMB) {
    final fileSizeInBytes = file.lengthSync();
    final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    return fileSizeInMB <= maxSizeMB;
  }

  static String getFileSizeString(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  static String getFileExtension(String filename) {
    return filename.split('.').last.toLowerCase();
  }

  static String getFileNameWithoutExtension(String filename) {
    return filename.split('.').first;
  }
}
