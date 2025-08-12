class Card {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String rarity;
  final String collectionId;
  final DateTime createdAt;

  Card({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.rarity,
    required this.collectionId,
    required this.createdAt,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      rarity: json['rarity'] as String,
      collectionId: json['collection_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'rarity': rarity,
      'collection_id': collectionId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}