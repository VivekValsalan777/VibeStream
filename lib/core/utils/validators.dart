class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain an uppercase letter';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain a lowercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number';
    }
    return null;
  }

  static String? validatePasswordConfirm(String? password, String? confirm) {
    if (confirm == null || confirm.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirm) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (username.length > 30) {
      return 'Username must not exceed 30 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(username)) {
      return 'Username can only contain letters, numbers, hyphens, and underscores';
    }
    return null;
  }

  static String? validateSongTitle(String? title) {
    if (title == null || title.isEmpty) {
      return 'Song title is required';
    }
    if (title.length > 100) {
      return 'Song title must not exceed 100 characters';
    }
    return null;
  }

  static String? validateArtistName(String? artist) {
    if (artist == null || artist.isEmpty) {
      return 'Artist name is required';
    }
    if (artist.length > 100) {
      return 'Artist name must not exceed 100 characters';
    }
    return null;
  }

  static String? validatePlaylistName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Playlist name is required';
    }
    if (name.length > 50) {
      return 'Playlist name must not exceed 50 characters';
    }
    return null;
  }
}
