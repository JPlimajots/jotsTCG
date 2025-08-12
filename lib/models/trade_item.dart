class TradeItem {
  final String id;
  final String tradeId;
  final String userCardId;
  final String type;

  TradeItem({
    required this.id,
    required this.tradeId,
    required this.userCardId,
    required this.type,
  });

  factory TradeItem.fromJson(Map<String, dynamic> json) {
    return TradeItem(
      id: json['id'] as String,
      tradeId: json['trade_id'] as String,
      userCardId: json['user_card_id'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'trade_id': tradeId,
      'user_card_id': userCardId,
      'type': type,
    };
  }
}
