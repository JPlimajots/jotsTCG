class Collection {
  final String id;
  final String name;
  final String? description;
  final DateTime? releaseDate;
  final String? iconUrl;
  final DateTime createdAt;

  Collection({
    required this.id,
    required this.name,
    this.description,
    this.releaseDate,
    this.iconUrl,
    required this.createdAt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      releaseDate: json['release_date'] != null ? DateTime.parse(json['release_date'] as String) : null,
      iconUrl: json['icon_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'release_date': releaseDate?.toIso8601String(),
      'icon_url': iconUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}