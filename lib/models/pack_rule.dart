class PackRule {
  final String id;
  final String packId;
  final String rarity;
  final double probability;

  PackRule({
    required this.id,
    required this.packId,
    required this.rarity,
    required this.probability,
  });

  factory PackRule.fromJson(Map<String, dynamic> json) {
    return PackRule(
      id: json['id'] as String,
      packId: json['pack_id'] as String,
      rarity: json['rarity'] as String,
      probability: (json['probability'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'pack_id': packId,
      'rarity': rarity,
      'probability': probability,
    };
  }
}