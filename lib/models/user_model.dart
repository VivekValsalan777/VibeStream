class UserModel {
  final String uid;
  final String username;
  final String email;
  final String? profilePicture;
  final int uploadedSongsCount;
  final int playlistsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.profilePicture,
    this.uploadedSongsCount = 0,
    this.playlistsCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String?,
      uploadedSongsCount: json['uploadedSongsCount'] as int? ?? 0,
      playlistsCount: json['playlistsCount'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
      'uploadedSongsCount': uploadedSongsCount,
      'playlistsCount': playlistsCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? profilePicture,
    int? uploadedSongsCount,
    int? playlistsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      uploadedSongsCount: uploadedSongsCount ?? this.uploadedSongsCount,
      playlistsCount: playlistsCount ?? this.playlistsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
