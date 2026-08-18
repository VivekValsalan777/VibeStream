class FavoriteModel {
  final String id;
  final String userId;
  final String songId;
  final DateTime addedAt;

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.songId,
    required this.addedAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return FavoriteModel(
      id: docId ?? json['id'] as String,
      userId: json['userId'] as String,
      songId: json['songId'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'songId': songId,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  FavoriteModel copyWith({
    String? id,
    String? userId,
    String? songId,
    DateTime? addedAt,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      songId: songId ?? this.songId,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
