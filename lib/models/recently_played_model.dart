class RecentlyPlayedModel {
  final String id;
  final String userId;
  final String songId;
  final DateTime playedAt;

  RecentlyPlayedModel({
    required this.id,
    required this.userId,
    required this.songId,
    required this.playedAt,
  });

  factory RecentlyPlayedModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return RecentlyPlayedModel(
      id: docId ?? json['id'] as String,
      userId: json['userId'] as String,
      songId: json['songId'] as String,
      playedAt: DateTime.parse(json['playedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'songId': songId,
      'playedAt': playedAt.toIso8601String(),
    };
  }

  RecentlyPlayedModel copyWith({
    String? id,
    String? userId,
    String? songId,
    DateTime? playedAt,
  }) {
    return RecentlyPlayedModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      songId: songId ?? this.songId,
      playedAt: playedAt ?? this.playedAt,
    );
  }
}
