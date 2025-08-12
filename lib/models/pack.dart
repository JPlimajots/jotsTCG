class Pack {
  final String id;
  final String name;
  final String? description;
  final int costInCoins;
  final String? imageUrl;
  final DateTime createdAt;

  Pack({
    required this.id,
    required this.name,
    this.description,
    required this.costInCoins,
    this.imageUrl,
    required this.createdAt,
  });

  factory Pack.fromJson(Map<String, dynamic> json) {
    return Pack(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      costInCoins: json['cost_in_coins'] as int,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'name': name,
      'description': description,
      'cost_in_coins': costInCoins,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}