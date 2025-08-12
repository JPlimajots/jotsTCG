class Friendship {
  final String id;
  final String requesterId;
  final String addresseeId;
  final String status;
  final DateTime createdAt;

  Friendship({
    required this.id,
    required this.requesterId,
    required this.addresseeId,
    required this.status,
    required this.createdAt,
  });

  factory Friendship.fromJson(Map<String, dynamic> json) {
    return Friendship(
      id: json['id'] as String,
      requesterId: json['requester_id'] as String,
      addresseeId: json['addressee_id'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'requester_id': requesterId,
      'addressee_id': addresseeId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
