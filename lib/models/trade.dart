class Trade {
  final String id;
  final String offererId;
  final String receiverId;
  final String status;
  final DateTime createdAt;
  final DateTime? expiresAt;

  Trade({
    required this.id,
    required this.offererId,
    required this.receiverId,
    required this.status,
    required this.createdAt,
    this.expiresAt,
  });
  
  factory Trade.fromJson(Map<String, dynamic> json) {
    return Trade(
      id: json['id'] as String,
      offererId: json['offerer_id'] as String,
      receiverId: json['receiver_id'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
          : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'offerer_id': offererId,
      'receiver_id': receiverId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
    };
  }
}
