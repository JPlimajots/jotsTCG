class Profile {
  final String id;
  final String username;
  final String? avatarUrl;
  final int coins;
  final DateTime? updatedAt;

  Profile({
    required this.id,
    required this.username,
    this.avatarUrl,
    required this.coins,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String?,
      coins: json['coins'] as int,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'username': username,
      'avatar_url': avatarUrl,
      'coins': coins,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}