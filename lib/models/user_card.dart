class UserCard {
  final String id;
  final String userId;
  final String cardId;
  final int quantity;
  final DateTime createdAt;

  UserCard({
    required this.id,
    required this.userId,
    required this.cardId,
    required this.quantity,
    required this.createdAt,
  });

  factory UserCard.fromJson(Map<String, dynamic> json) {
    return UserCard(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      cardId: json['card_id'] as String,
      quantity: json['quantity'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'user_id': userId,
      'card_id': cardId,
      'quantity': quantity,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
