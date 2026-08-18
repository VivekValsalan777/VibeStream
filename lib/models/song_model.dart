class SongModel {
  final String id;
  final String title;
  final String artist;
  final String? album;
  final String? genre;
  final String audioUrl;
  final String? coverUrl;
  final String uploadedBy;
  final DateTime uploadedAt;
  final int playCount;
  final Duration? duration;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    this.album,
    this.genre,
    required this.audioUrl,
    this.coverUrl,
    required this.uploadedBy,
    required this.uploadedAt,
    this.playCount = 0,
    this.duration,
  });

  factory SongModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return SongModel(
      id: docId ?? json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String?,
      genre: json['genre'] as String?,
      audioUrl: json['audioUrl'] as String,
      coverUrl: json['coverUrl'] as String?,
      uploadedBy: json['uploadedBy'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      playCount: json['playCount'] as int? ?? 0,
      duration: json['duration'] != null ? Duration(seconds: json['duration'] as int) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'genre': genre,
      'audioUrl': audioUrl,
      'coverUrl': coverUrl,
      'uploadedBy': uploadedBy,
      'uploadedAt': uploadedAt.toIso8601String(),
      'playCount': playCount,
      'duration': duration?.inSeconds,
    };
  }

  SongModel copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? genre,
    String? audioUrl,
    String? coverUrl,
    String? uploadedBy,
    DateTime? uploadedAt,
    int? playCount,
    Duration? duration,
  }) {
    return SongModel(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      genre: genre ?? this.genre,
      audioUrl: audioUrl ?? this.audioUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      uploadedBy: uploadedBy ?? this.uploadedBy,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      playCount: playCount ?? this.playCount,
      duration: duration ?? this.duration,
    );
  }
}
