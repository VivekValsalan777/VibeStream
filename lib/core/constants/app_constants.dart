class AppConstants {
  // App Info
  static const String appName = 'VibeStream';
  static const String appVersion = '1.0.0';

  // API & Storage
  static const int maxUploadSizeMB = 50;
  static const int maxImageSizeMB = 10;
  static const List<String> supportedAudioFormats = ['mp3'];
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];

  // Validation
  static const int minPasswordLength = 8;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String songsCollection = 'songs';
  static const String playlistsCollection = 'playlists';
  static const String favoritesCollection = 'favorites';
  static const String recentlyPlayedCollection = 'recently_played';

  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration debounceDelay = Duration(milliseconds: 500);
}
