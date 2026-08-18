class PlaylistModel {
  final String id;
  final String name;
  final String ownerUid;
  final String? coverUrl;
  final List<String> songIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  PlaylistModel({
    required this.id,
    required this.name,
    required this.ownerUid,
    this.coverUrl,
    this.songIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return PlaylistModel(
      id: docId ?? json['id'] as String,
      name: json['name'] as String,
      ownerUid: json['ownerUid'] as String,
      coverUrl: json['coverUrl'] as String?,
      songIds: List<String>.from(json['songIds'] as List? ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerUid': ownerUid,
      'coverUrl': coverUrl,
      'songIds': songIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  PlaylistModel copyWith({
    String? id,
    String? name,
    String? ownerUid,
    String? coverUrl,
    List<String>? songIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerUid: ownerUid ?? this.ownerUid,
      coverUrl: coverUrl ?? this.coverUrl,
      songIds: songIds ?? this.songIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
